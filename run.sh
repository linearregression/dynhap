#!/bin/bash

/usr/sbin/haproxy -D -f /etc/haproxy/haproxy.cfg -p /var/run/haproxy.pid
./confd -node ${REDIS_HOST}:${REDIS_PORT}
