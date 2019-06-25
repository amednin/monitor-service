from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base
import json


with open('config.json') as json_data_file:
    config = json.load(json_data_file)

db_config = config['mysql']
user = db_config['user']
password = db_config['password']
host = db_config['host']
db_name = db_config['db_name']
port = db_config['port']
engine = create_engine(
    'mysql+mysqlconnector://' + user + ':' + password + '@' + host + ':' + str(port) + '/' + db_name,
    echo=True)

Base = declarative_base()

Session = sessionmaker(expire_on_commit=False)
Session.configure(bind=engine)
