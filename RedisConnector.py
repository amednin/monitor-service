import redis
import json
import time
from models.queries import insert_audit_log, insert_error_log, insert_log
from models.constants import LogType, ErrorSeverity
from alert_handler.AlertDispatcher import AlertDispatcher


class RedisConnector:
    valid_user = True

    def __init__(self, config, channels_to_listen=[]):
        self.r = redis.StrictRedis(**config)
        self.p = self.r.pubsub()
        self.channels_to_listen = channels_to_listen
        self.alert_dispatcher = AlertDispatcher(self)

    def set_db_manager(self, session):
        self.db_session = session

    def subscribe_to(self, channels):
        self.p.subscribe(channels)

    def publish_to(self, channel, message):
        self.r.publish(channel, message)

    def start_listening(self):
        while True:
            message = self.p.get_message()

            if message and message['type'] == 'message':
                message_data = json.loads(message['data'])

                self.listen_to_logs_channel(message, message_data)

                self.listen_to_activity(message_data)

                self.listen_to_error(message_data)

                """
                Example of an alert being listened via 'error-channel'
                
                if message_data['type'] == 'ERROR-ALERT':
                    print('********** E R R O R    A L E R T **********')
                    print('DATE: ', message_data['message']['datetime'])
                    print('MESSAGE: ', message_data['message']['message'])
                    print('********************************************')
                """

            time.sleep(0.05)

    def listen_to_logs_channel(self, redis_message, message_data):
        if redis_message.get('channel', '') == 'logs-channel':
            insert_log(self.db_session, message_data)

    def listen_to_activity(self, message_data):
        log_type = message_data['type']

        if log_type == LogType.ACTIVITY.value:
            if not self.is_valid_user_session(message_data):
                self.alert_dispatcher.send_no_auth_alert()
            else:
                insert_audit_log(self.db_session, message_data['message'])

    def listen_to_error(self, message_data):
        log_type = message_data['type']

        if log_type == LogType.ERROR.value:
            poi_log = insert_error_log(self.db_session, message_data['message'])

            if poi_log.ErrorLog.severity == ErrorSeverity.EXCEPTION.value:
                self.alert_dispatcher.send_error_alert(poi_log)

    @staticmethod
    def is_valid_user_session(data):
        return data['message'].get('identifier').get('token', False)


