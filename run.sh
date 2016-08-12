#!/bin/bash

SERVICE_NAME=${REG_AVAHI_NAME:-lbreg}

ulimit -n 131083
/usr/bin/redis-server /etc/redis/redis.conf
sleep 2
/usr/sbin/haproxy -D -f /etc/haproxy/haproxy.cfg -p /var/run/haproxy.pid
mkdir -p /var/run/dbus
/bin/dbus-daemon --system
/usr/sbin/avahi-daemon -D

metadata_ip=$(/usr/bin/curl http://169.254.169.254/latest/meta-data/local-ipv4 2>/dev/null)
MYIP=${DOCKER_HOST_IP:-metadata_ip}

/usr/bin/avahi-publish -f -a ${SERVICE_NAME}.local ${MYIP} &
/usr/bin/avahi-publish -f -H ${SERVICE_NAME}.local -s ${SERVICE_NAME} _http._tcp 6379 &


./confd
