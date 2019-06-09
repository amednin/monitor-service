# Monitor Service

A microservice written in Python that will handle logging persistence by listening redis channles

- audit-channel
- errors-channel
- logs-channel

## Requirements

#### Python
Current python version is 3.7.3 during the development

Current pip in version 19.1.1 during the development

In case of errors during installation: `python -m ensurepip --default-pip`

##### Working with Python 3 in OSX
By default OSX comes with Python 2.
For installing version 3, homebrew needs you to run
`export PATH="/usr/local/opt/python/libexec/bin:$PATH"`
you can source it to persist the path exported.
Now you can install Python 3
```
brew install python
```

#### Dependencies manager
For distributing the project `pipenv` will be used

For OSX: `brew install pipenv`

For installation through pip:
```
pip install pipenv
```

##### Virtual environment
Only use virtual environment for having more than one python and dependencies installation based on different package versions

How to install: `pip install --user pipenv` for a user's installation. See reference https://pipenv.readthedocs.io/en/latest/install/#installing-pipenv for more information

You will need to add it to your PATH

For example
`export PATH="$PATH:/Users/amed/Library/Python/3.7/bin"`
and then source it
`source ~/.profile`

To freeze package versions into a requirements.txt you could run
```
pipenv run pip freeze > requirements.txt
```

##### Database
Microservices project running with Mysql 5.7

If you want to create database schema through sqlalchemy ORM tool, you can execute `create_db_schema()` from models/queries.py.
Prerequisite is to have a `monitor_service` database already create. Otherwise you could use the `sql/monitor-service.sql` file to execute on your database client.
You need to populate `ActivityType` table executing `populate_default()` from models/queries.py

## Troubleshooting
Running pip in order to install ` pipenv` in OSX may cause an error similar to
```
Traceback (most recent call last):
  File "/usr/local/bin/pip", line 7, in <module>
    from pip import main
ImportError: cannot import name main
```

Fix: `python -m pip install pipenv`

## Pre-requirements

`ActivityType` table should contain data to start working with the database.

For that you can run `models/queries.py:populate_default()` function

## Start Project

Run Redis: `redis-server & redis-cli`

Start Python redis subscription: `python main.py`
