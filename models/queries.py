from models.base import Base, engine
from models.entities import ActivityType, PoiLog, AuditLog, ErrorLog
from models.constants import ActivityType as ActivityTypeEnum
import sys
import json


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
        poi_log_entity = create_poi_log_entity(data, log_type)

        entity_name = data['key'].split('.')[2]
        current_value = json.dumps(data['request']['payload'])
        action = data['request']['request']
        audit_log_entity = AuditLog(current_value=current_value, entity_name=entity_name, action=action)

        if data['request'].get('old_value', False):
            old_value = data['request']['old_value'] # Confirm this is going to be the place for old_value
            audit_log_entity.old_value = old_value

        if data.get('notes', False): # confirm this
            notes = data['notes']
            audit_log_entity.notes = notes

        poi_log_entity.AuditLog = audit_log_entity

        db_session.add(poi_log_entity)
        db_session.commit()
    except Exception:
        db_session.rollback()
        print('Error while creating Database!', sys.exc_info()[0])
        raise
    finally:
        db_session.close()


def insert_error_log(db_session, data):
    poi_to_return = None

    try:
        activity_type = get_activity_by_type(db_session, ActivityTypeEnum.ERROR.value)
        poi_log = create_poi_log_entity(data, activity_type)
        error_log = ErrorLog(severity=data['severity'], message=data['friendly_message'],
                             code=data['friendly_code'], trace_message=data['real_error'])

        poi_log.ErrorLog = error_log
        poi_to_return = poi_log
        db_session.add(poi_log)
        db_session.commit()

    except Exception:
        db_session.rollback()
        print('Error while creating Database!', sys.exc_info()[0])
        raise
    finally:
        return poi_to_return


def get_activity_by_type(db_session, a_type):
    return db_session \
        .query(ActivityType) \
        .filter(ActivityType.type == a_type) \
        .first()


def create_poi_log_entity(data, activity_type_entity):
    poi_log_entity = PoiLog()

    if data.get('user', False):
        user_data = data['user']

        if data['user'].get('id', False):
            poi_log_entity.user_id = int(user_data['id'])

        if data['user'].get('username', False):
            poi_log_entity.username = user_data['username']

        poi_log_entity.user_agent = data['from']['agent']
        poi_log_entity.ip = data['from']['ip']

    poi_log_entity.ActivityType = activity_type_entity

    return poi_log_entity
