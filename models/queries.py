from models.base import Base, engine
from models.entities import ActivityType, PoiLog, AuditLog, ErrorLog, MetricsLog, Log, Client
from models.constants import ActivityType as ActivityTypeEnum
import sys
import json
from datetime import datetime, timedelta
from sqlalchemy import and_


LOGIN_URI = '/api/login'


def create_db_schema():
    print('Creating database schema...')
    try:
        Base.metadata.create_all(engine)
        print('Database schema created!')
    except Exception:
        print('Error while creating Database!', sys.exc_info()[0])
        raise


def populate_default(db_session):
    act_type1 = ActivityType(type=ActivityTypeEnum.ACTIVITY.value)
    act_type2 = ActivityType(type=ActivityTypeEnum.BENCHMARK.value)
    act_type3 = ActivityType(type=ActivityTypeEnum.ERROR.value)

    db_session.add(act_type1)
    db_session.add(act_type2)
    db_session.add(act_type3)
    db_session.commit()
    db_session.query(ActivityType).all()
    db_session.close()


def insert_audit_log(db_session, data):
    try:
        log_type = get_activity_by_type(db_session, ActivityTypeEnum.ACTIVITY.value)
        poi_log_entity = create_poi_log_entity(db_session, data, log_type)

        entity_name = data['key'].split('.')[2]
        current_value = json.dumps(data['request']['payload'])
        action = data['request']['request']
        audit_log_entity = AuditLog(current_value=current_value, entity_name=entity_name.capitalize(), action=action)

        if data['request'].get('old_value', False):
            old_value = data['request']['old_value']
            audit_log_entity.old_value = old_value

        if data.get('notes', False):
            notes = data['notes']
            audit_log_entity.notes = notes

        poi_log_entity.AuditLog = audit_log_entity

        # Register benchmarking info
        if data['benchmark']:
            metrics_entity = insert_metrics(poi_log_entity, data)
            poi_log_entity.MetricsLog = metrics_entity

        db_session.add(poi_log_entity)
        db_session.commit()
    except Exception:
        db_session.rollback()
        print('Error while inserting AuditLog!', sys.exc_info()[0])
        raise
    finally:
        db_session.close()


def insert_error_log(db_session, data):
    poi_to_return = None

    try:
        activity_type = get_activity_by_type(db_session, ActivityTypeEnum.ERROR.value)
        poi_log = create_poi_log_entity(db_session, data, activity_type)
        error_log = ErrorLog(severity=data['severity'], message=data['friendly_message'],
                             code=data['friendly_code'], trace_message=data['real_error'])

        if data.get('meta_data', False):
            error_log.meta_data = json.dumps(data['metadata'])

        poi_log.ErrorLog = error_log
        poi_to_return = poi_log
        db_session.add(poi_log)
        db_session.commit()

    except Exception:
        db_session.rollback()
        print('Error while inserting ErrorLog!', sys.exc_info()[0])
        raise
    finally:
        return poi_to_return


def insert_metrics(poi_log_entity, data):
    metrics_entity = MetricsLog()
    benchmark_data = data['benchmark']
    metrics_entity.requested_at = datetime.fromtimestamp(int(benchmark_data['requested_at']))
    metrics_entity.response_at = datetime.fromtimestamp(int(benchmark_data['response_at']))
    metrics_entity.response_time_ms = benchmark_data['response_time_ms']
    metrics_entity.resource = data['request']['request']
    metrics_entity.method = data['request']['method']

    poi_log_entity.MetricsLog = metrics_entity

    return metrics_entity


def insert_log(db_session, data):
    try:
        log_entity = Log(service=data['service'], type=data['type'], log=data['message'])

        db_session.add(log_entity)
        db_session.commit()

    except Exception:
        db_session.rollback()
        print('Error while inserting a Log entity!', sys.exc_info()[0])
        raise
    finally:
        db_session.close()


def get_activity_by_type(db_session, a_type):
    return db_session \
        .query(ActivityType) \
        .filter(ActivityType.type == a_type) \
        .first()


def create_poi_log_entity(db_session, data, activity_type_entity):
    client = get_or_create_client(db_session, data)
    poi_log_entity = PoiLog()

    if data.get('user', False):
        user_data = data['user']
        if data['user'].get('id', False):
            poi_log_entity.user_id = int(user_data['id'])

        if data['from'].get('ip', False):
            poi_log_entity.ip = data['from']['ip']

    poi_log_entity.ActivityType = activity_type_entity
    poi_log_entity.Client = client

    return poi_log_entity


def get_or_create_client(db_session, data):
    username = data['user']['email']
    user_agent = data['from']['agent']

    try:
        client_found = db_session \
            .query(Client) \
            .filter(and_(Client.username == username, Client.user_agent == user_agent)) \
            .first()

        if client_found:
            return client_found

        return Client(username=username, user_agent=user_agent)
    except Exception:
        db_session.rollback()
        print('Error while getting or creating a Client entity!', sys.exc_info()[0])
        raise


def get_login_requests_within(db_session, method, seconds):
    try:
        now = datetime.now()
        seconds_ago = now - timedelta(seconds=seconds)

        return db_session.query(PoiLog)\
            .join(PoiLog.MetricsLog)\
            .filter(
                and_(
                    PoiLog.created_at > seconds_ago.strftime("%Y-%m-%d %H:%M:%S"),
                    PoiLog.created_at <= now.strftime("%Y-%m-%d %H:%M:%S"),
                    MetricsLog.method == 'POST',
                    MetricsLog.resource == LOGIN_URI
                )
            )\
            .count()

    except Exception:
        db_session.rollback()
        print('Error while querying metrics log!', sys.exc_info()[0])
        raise
    finally:
        db_session.close()
