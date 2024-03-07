FROM python:3
WORKDIR /usr/src/app
COPY django_tutorial ./
COPY settings.py django_tutorial/settings.py
RUN pip install --root-user-action=ignore --upgrade pip && pip install --root-user-action=ignore django mysqlclient
RUN chmod +x polls.sh
ENV ALLOWED_HOSTS=*
ENV HOST=mariadb
ENV USUARIO=django
ENV CONTRA=django
ENV BASE_DATOS=django
ENV DJANGO_SUPERUSER_PASSWORD=admin
ENV DJANGO_SUPERUSER_USERNAME=admin
ENV DJANGO_SUPERUSER_EMAIL=admin@example.org
CMD /usr/src/app/polls.sh