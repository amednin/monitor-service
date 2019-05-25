import redis
import time
import json
from datetime import  datetime
from models.queries import insert_audit_log, insert_error_log
from models.base import Session
from models.constants import LogType, ErrorSeverity


class MonitorRedisCheck:
    def __init__(self):
        self.r = redis.StrictRedis(host='localhost', port=6379, db=0)
        self.p = self.r.pubsub()
        self.p.subscribe('audit-channel', 'errors-channel', 'error-alert')

    def listen_to_redis(self):
        print('Start listening to Redis `audit-channel`, `errors-channel`')
        db_session = Session()
        while True:
            message = self.p.get_message()
            if message and message['type'] == 'message':
                print(message)

                # TODO: Do verification for authenticated user (token)

                message_data = json.loads(message['data'])
                log_type = message_data['type']

                if log_type == LogType.ACTIVITY.value:
                    insert_audit_log(db_session, message_data['message'])
                elif log_type == LogType.ERROR.value:
                    poi_log = insert_error_log(db_session, message_data['message'])

                    if poi_log.ErrorLog.severity == ErrorSeverity.EXCEPTION.value:
                        self.send_error_alert(poi_log)
                elif log_type == 'ERROR-ALERT':
                    print('********** E R R O R    A L E R T **********')
                    print('DATE: ', message_data['message']['datetime'])
                    print('CODE: ', message_data['message']['code'])
                    print('STACK TRACE: ', message_data['message']['trace'])
                    print('********************************************')

            time.sleep(0.05)

    def send_error_alert(self, poi_log):
        message = {
            "type": 'ERROR-ALERT',
            "message": {
                "datetime": poi_log.created_at.strftime("%m/%d/%Y, %H:%M:%S"),
                "code": poi_log.ErrorLog.code,
                "trace": poi_log.ErrorLog.trace_message
            }
        }
        self.send_alert('error-alert', json.dumps(message))

    def send_alert(self, channel, message):
        self.r.publish(channel, message)
