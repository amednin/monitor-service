from enum import Enum


class ActivityType(Enum):
    ACTIVITY = 'ACTIVITY'
    BENCHMARK = 'BENCHMARK'
    ERROR = 'ERROR'


class LogType(Enum):
    ACTIVITY = 'activity'
    ERROR = 'error'


class ErrorSeverity(Enum):
    EXCEPTION = 'exception'
    INFO = 'info'
    WARNING = 'warning'
