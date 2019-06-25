from RedisConnector import RedisConnector


def create_redis_connector(redis_config):
    r_connector = RedisConnector(redis_config)

    return r_connector
