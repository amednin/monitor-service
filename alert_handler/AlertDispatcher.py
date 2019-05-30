import json


class AlertDispatcher:
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