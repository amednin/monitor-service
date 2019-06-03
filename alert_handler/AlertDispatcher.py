import json
from datetime import datetime


class AlertDispatcher:
    def __init__(self, message_broker):
        self.message_broker = message_broker

    def send_error_alert(self, poi_log):
        message = {
            "type": 'ERROR-ALERT',
            "message": {
                "datetime": poi_log.created_at.strftime("%m/%d/%Y, %H:%M:%S"),
                "code": poi_log.ErrorLog.code,
                "message": poi_log.ErrorLog.trace_message
            }
        }
        self.send_alert('error-alert', json.dumps(message))

    def send_no_auth_alert(self):
        not_auth_message = {
            "type": 'ERROR-ALERT',
            "message": {
                "datetime": datetime.now().strftime("%m/%d/%Y, %H:%M:%S"),
                "message": "Request Forbidden by invalid user!"
            }
        }
        self.send_alert('error-alert', json.dumps(not_auth_message))

    def send_alert(self, channel, message):
        self.message_broker.r.publish(channel, message)
