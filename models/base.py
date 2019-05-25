from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base


engine = create_engine('mysql+mysqlconnector://root:123@localhost:3306/monitor_service', echo=True)

Base = declarative_base()

Session = sessionmaker(expire_on_commit=False)
Session.configure(bind=engine)
