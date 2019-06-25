import json
from MonitorService import MonitorService


with open('config.json') as json_data_file:
    config = json.load(json_data_file)
monitor_manager = MonitorService(config)
monitor_manager.start_listening()
