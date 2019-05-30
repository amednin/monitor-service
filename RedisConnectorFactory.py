import redis


def create_redis_connector(connector, redis_config):
    connector_config = redis_config['connectors'][connector]
    r = redis.StrictRedis(**connector_config)

    return r
