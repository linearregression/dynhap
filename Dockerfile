FROM ubuntu:14.04

RUN apt-get update --fix-missing
RUN apt-get install -y wget curl haproxy redis-server libnl-utils dbus avahi-daemon avahi-utils

WORKDIR /home

RUN wget https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64
RUN mv confd-0.11.0-linux-amd64 confd
RUN chmod +x confd

RUN mkdir /etc/confd
COPY ./haproxy_gracefull_reload.sh ./haproxy_gracefull_reload.sh
COPY ./confd /etc/confd
COPY ./run.sh run.sh
COPY ./redis.conf /etc/redis/
COPY ./avahi-daemon.conf /etc/avahi/

RUN chmod +x run.sh
RUN chmod +x haproxy_gracefull_reload.sh

EXPOSE 80 6379 8099 5353/udp

CMD ["/home/run.sh"]
