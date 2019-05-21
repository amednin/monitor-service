from models.base import Base, Session, engine
from models.entities import ActivityType, PoiLog
import sys


def create_db_schema():
    print('Creating database schema...')
    try:
        Base.metadata.create_all(engine)
        print('Database schema created!')
    except:
        print('Error while creating Database!', sys.exc_info()[0])
        raise


def populate_default():
    act_type1 = ActivityType(id=0, type="ACTIVITY")
    act_type2 = ActivityType(id=0, type="BENCHMARK")
    act_type3 = ActivityType(id=0, type="ERROR")

    session = Session()
    session.add(act_type1)
    session.add(act_type2)
    session.add(act_type3)
    session.commit()
    session.query(ActivityType).all()
    session.close()


def insert_poi_entity(data):
    poi_log_entry = PoiLog(id=0, activity_type_id=1, user_id=data['user_id'], username='user1', user_agent='Mozilla')
    session = Session()
    session.add(poi_log_entry)
    session.commit()
    session.query(PoiLog).all()
    session.close()
