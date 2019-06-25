from models.base import Session
from RedisConnectorFactory import create_redis_connector

"""
Facade to provide a single entry point to all functionality
for the underlying service
"""


class MonitorService:
    def __init__(self, config):
        self.config = config
        default_config = self.load_config('default')

        channels_to_subscribe = self.get_channels_to_subscribe(default_config['channels']['listen_to'])
        self.redis_connector = create_redis_connector(default_config['redis_connector'])
        self.redis_connector.subscribe_to(channels_to_subscribe)

        db_session = Session()
        self.redis_connector.set_db_manager(db_session)

    def start_listening(self):
        print('Start listening to Redis `audit-channel`, `errors-channel`, `logs-channel`')
        self.redis_connector.start_listening()

    def load_config(self, config_key):
        redis_info = self.config['redis']
        connector_config = redis_info['connectors'][config_key]
        channels_config = redis_info['channels'][config_key]

        return {'redis_connector': connector_config, 'channels': channels_config}

    @staticmethod
    def is_valid_user_session(data):
        return data['message'].get('identifier').get('token', False)

    @staticmethod
    def get_channels_to_subscribe(listen_to):
        # Current known channels
        audit_channel = listen_to.get('audit')
        errors_channel = listen_to.get('errors')
        logs_channel = listen_to.get('logs')

        return [audit_channel, errors_channel, logs_channel, 'error-alert']
