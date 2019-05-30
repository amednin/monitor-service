import time
import json
from datetime import datetime
from models.queries import insert_audit_log, insert_error_log, insert_log
from models.base import Session
from models.constants import LogType, ErrorSeverity
from RedisConnectorFactory import create_redis_connector


class MonitorRedisCheck:
    def __init__(self):
        with open('config.json') as json_data_file:
            self.config = json.load(json_data_file)
            self.connect_and_subscribe()

    def listen_to_redis(self):
        print('Start listening to Redis `audit-channel`, `errors-channel`, `logs-channel`')
        db_session = Session()
        while True:
            message = self.p.get_message()

            if message and message['type'] == 'message':
                message_data = json.loads(message['data'])

                if message.get('channel', '') == "logs-channel":
                    insert_log(db_session, message_data)
                else:
                    print(message)

                    if not MonitorRedisCheck.is_valid_user_session(message_data):
                        not_auth_message = {
                            "type": 'AUTH-ALERT',
                            "message": {
                                "datetime": datetime.now().strftime("%m/%d/%Y, %H:%M:%S"),
                                "message": "Request Forbidden by invalid user!"
                            }
                        }
                        self.send_alert('error-alert', json.dumps(not_auth_message))
                        continue

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

    @staticmethod
    def is_valid_user_session(data):
        return data['message'].get('identifier').get('token', False)

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

    def connect_and_subscribe(self):
        redis_info = self.config['redis']
        self.r = create_redis_connector('default', redis_info)
        self.p = self.r.pubsub()
        channels = MonitorRedisCheck.get_channels_to_subscribe('default', redis_info['channels'])
        self.p.subscribe(channels)

    @staticmethod
    def get_channels_to_subscribe(for_connector, channels_config):
        listen_to = channels_config[for_connector]['listen_to']

        audit_channel = listen_to['audit']
        errors_channel = listen_to['errors']
        logs_channel = listen_to['logs']

        return [audit_channel, errors_channel, logs_channel]
