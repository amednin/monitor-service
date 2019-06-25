import sqlalchemy as db
from sqlalchemy import Column
from sqlalchemy.orm import relationship
from models.base import Base


class ActivityType(Base):
    __tablename__ = 'ActivityType'

    id = Column(db.INTEGER, primary_key=True, autoincrement=True)
    type = Column(db.String(45))

    def __repr__(self):
        return "<{0} Id: {1} - Type: {2}".format(self.__class__.__name__, self.id, self.type)


class Client(Base):
    __tablename__ = 'Client'

    id = Column(db.INTEGER, primary_key=True, autoincrement=True)
    username = Column(db.String(45))
    user_agent = Column(db.String(100))

    def __repr__(self):
        return "<{0} Username: {1} - UserAgent: {2}".format(self.__class__.__name__, self.username, self.user_agent)


class PoiLog(Base):
    __tablename__ = 'PoiLog'

    id = Column(db.Integer, primary_key=True, unique=True, autoincrement=True)
    activity_type_id = Column(db.Integer, db.schema.ForeignKey('ActivityType.id'), nullable=False)
    client_id = Column(db.Integer, db.schema.ForeignKey('Client.id'), nullable=False)
    created_at = Column(db.DateTime, default=db.func.now())
    user_id = Column(db.Integer)
    ip = Column(db.String(45))

    ActivityType = relationship('ActivityType', backref='PoiLog', cascade='all, delete-orphan', single_parent=True)
    Client = relationship('Client', backref='PoiLog', cascade='all, delete-orphan', single_parent=True)
    AuditLog = relationship('AuditLog', uselist=False, back_populates='PoiLog', cascade='all, delete-orphan', single_parent=True)
    ErrorLog = relationship('ErrorLog', uselist=False, back_populates='PoiLog', cascade='all, delete-orphan', single_parent=True)
    MetricsLog = relationship('MetricsLog', uselist=False, back_populates='PoiLog', cascade='all, delete-orphan', single_parent=True)

    def __repr__(self):
        return "<{0} Id: {1} - LogType: {2}".format(self.__class__.__name__, self.id, self.ActivityType.type)


class AuditLog(Base):
    __tablename__ = 'AuditLog'

    poi_log_id = Column(db.Integer, db.schema.ForeignKey('PoiLog.id'), nullable=False, primary_key=True)
    current_value = Column(db.String(500))
    old_value = Column(db.String(500))
    entity_name = Column(db.String(45))
    entity_id = Column(db.Integer)
    action = Column(db.String(100))
    notes = Column(db.String(1000))

    PoiLog = relationship('PoiLog', back_populates='AuditLog')

    def __repr__(self):
        return "<{0} PoiLogId: {1} - EntityName: {2}".format(self.__class__.__name__, self.poi_log_id, self.entity_id)


class ErrorLog(Base):
    __tablename__ = 'ErrorLog'

    poi_log_id = Column(db.Integer, db.schema.ForeignKey('PoiLog.id'), nullable=False, primary_key=True)
    severity = Column(db.String(45))
    message = Column(db.String(500))
    code = Column(db.Integer)
    trace_message = Column(db.String(1000))
    meta_data = Column(db.String(1000))

    PoiLog = relationship('PoiLog', back_populates='ErrorLog')

    def __repr__(self):
        return "<{0} PoiLogId: {1} - EntityName: {2}".format(self.__class__.__name__, self.poi_log_id, self.severity)


class MetricsLog(Base):
    __tablename__ = 'MetricsLog'

    poi_log_id = Column(db.Integer, db.schema.ForeignKey('PoiLog.id'), nullable=False, primary_key=True)
    cpu_usage = Column(db.DECIMAL)
    response_time_ms = Column(db.DECIMAL)
    requested_at = Column(db.DateTime)
    response_at = Column(db.DateTime)
    resource = Column(db.String(100))
    method = Column(db.String(45))

    PoiLog = relationship('PoiLog', back_populates='MetricsLog')

    def __repr__(self):
        return "<{0} PoiLogId: {1} - Resource: {2}".format(self.__class__.__name__, self.poi_log_id, self.resource)


class Log(Base):
    __tablename__ = 'Log'

    id = Column(db.Integer, primary_key=True, unique=True, autoincrement=True)
    logged_at = Column(db.DateTime, default=db.func.now())
    log = Column(db.String(1000))
    type = Column(db.String(45))
    service = Column(db.String(45))

    def __repr__(self):
        return "<{0} Service: {1} - Type: {2} - Date: {3}"\
            .format(self.__class__.__name__, self.service, self.type, self.logged_at)
