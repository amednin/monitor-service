from enum import Enum


class ActivityType(Enum):
    ACTIVITY = 'ACTIVITY'
    BENCHMARK = 'BENCHMARK'
    ERROR = 'ERROR'


class LogType(Enum):
    ACTIVITY = 'activity'
    ERROR = 'error'


class ErrorSeverity(Enum):
    LOW = 'low'
    MEDIUM = 'medium'
    HIGH = 'high'
