import json
from datetime import datetime


class AlertDispatcher:
    def __init__(self, message_broker):
        self.message_broker = message_broker

    def send_error_alert(self, poi_log):
        message = {
            "type": 'error-alert',
            "message": {
                "datetime": poi_log.created_at.strftime("%m/%d/%Y, %H:%M:%S"),
                "code": poi_log.ErrorLog.code,
                "message": poi_log.ErrorLog.trace_message
            }
        }
        self.send_alert('error-alert', json.dumps(message))

    def send_no_auth_alert(self):
        not_auth_message = {
            "type": 'error-alert',
            "message": {
                "datetime": datetime.now().strftime("%m/%d/%Y, %H:%M:%S"),
                "message": "Request Forbidden by invalid user!"
            }
        }
        self.send_alert('error-alert', json.dumps(not_auth_message))

    def send_log_alert(self, message_data):
        message = {
            "type": 'error-alert',
            "message": {
                "datetime": datetime.now().strftime("%m/%d/%Y, %H:%M:%S"),
                "message": message_data['message']
            }
        }
        self.send_alert('error-alert', json.dumps(message))

    def send_benchmark_alert(self, threshold, value):
        message = {
            "type": 'error-alert',
            "message": {
                "datetime": datetime.now().strftime("%m/%d/%Y, %H:%M:%S"),
                "message": '[BENCHMARK]: ' + threshold + ' threshold has violate the minimum allowed value with ' + str(value)
            }
        }
        self.send_alert('error-alert', json.dumps(message))

    def send_alert(self, channel, message):
        self.message_broker.r.publish(channel, message)
