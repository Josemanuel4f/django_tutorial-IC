#! /bin/sh

sleep 5
cd django_tutorial/
python3 manage.py migrate
python3 manage.py createsuperuser --noinput
python3 manage.py collectstatic --no-input
python3 manage.py runserver 0.0.0.0:8004
