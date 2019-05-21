from nameko.rpc import rpc
from models.queries import insert_poi_entity


class AuditLogService:
    name = 'audit_log_service'

    @rpc
    def register(self, data):
        print('Data received', data)
        # session = get_session_handler
        insert_poi_entity(data)
        return True
