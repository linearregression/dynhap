#!/bin/bash

ulimit -n 131083
/usr/bin/forever start ./ipb.js
/usr/bin/redis-server /etc/redis/redis.conf
sleep 2
/usr/sbin/haproxy -D -f /etc/haproxy/haproxy.cfg -p /var/run/haproxy.pid
./confd
