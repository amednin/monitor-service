import redis
import time
import json
from models.queries import insert_poi_entity, insert_error_log, get_activity_by


class MonitorRedisCheck:
    def __init__(self):
        self.r = redis.StrictRedis(host='localhost', port=6379, db=0)
        self.p = self.r.pubsub()
        self.p.subscribe('audit-channel', 'errors-channel')

    def listen_to_redis(self):
        print('Start listening to Redis `audit-channel`, `errors-channel')
        while True:
            message = self.p.get_message()

            if message:
                message_data = json.loads(message['data'])

                if message['type'] == 'message':
                    activity_id = get_activity_by()
                    insert_poi_entity(message_data, activity_id)
                if message['type'] == 'error':
                    activity_id = get_activity_by('ERROR')
                    insert_error_log(message_data, activity_id)
                print(message)

            time.sleep(0.05)
