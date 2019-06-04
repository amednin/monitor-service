import json


def equal_to(value1, value2):
    return value1 == value2


def less_than(value1, value2):
    return value1 < value2


def less_equal_than(value1, value2):
    return value1 <= value2


def greater_than(value1, value2):
    return value1 > value2


def greater_equal_than(value1, value2):
    return value1 < value2


class ThresholdHandler:
    def __init__(self):
        with open('config.json') as json_data_file:
            # metrics_threshold in json should contain benchmarking keys the same as "benchmark" key from redis message
            config = json.load(json_data_file)
            self.threshold_params = config['metrics_threshold']
        self.comparators = {
            '=': equal_to,
            '<': less_than,
            '<=': less_equal_than,
            '>': greater_than,
            '>=': greater_equal_than
        }

    def do_benchmark_analysis(self, benchmarking_data, alert_dispatcher):
        for key, value in benchmarking_data.items():
            if self.should_raise_alert(key, value, '>'):
                alert_dispatcher.send_benchmark_alert(key, value)

    def should_raise_alert(self, threshold, value, comparator='='):
        if threshold in self.threshold_params.keys():
            return self.compare(value, comparator, self.threshold_params[threshold])

        return False

    def compare(self, value_to_compare, comparator, threshold):
        try:
            return self.comparators[comparator](value_to_compare, threshold)
        except:
            print('No valid comparator provided!', comparator)

    def analyze_requests_in_time(self, data):
        pass