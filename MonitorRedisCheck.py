import redis
import time
from nameko.standalone.rpc import ClusterRpcProxy
import json


class MonitorRedisCheck:
    def __init__(self):
        self.r = redis.StrictRedis(host='localhost', port=6379, db=0)
        self.p = self.r.pubsub()
        self.p.subscribe('audit-channel')

    def listen_to_redis(self):
        print('Start listening to Redis `audit-channel`')
        while True:
            message = self.p.get_message()
            if message and message['type'] == 'message':
                with ClusterRpcProxy({'AMQP_URI': 'amqp://guest:guest@localhost:5672/'}) as cluster_rpc:
                    cluster_rpc.audit_log_service.register(json.loads(message['data']))
                    # self.audit_log_rpc.register(message['data'])
                    print(message)
            time.sleep(0.5)
