#!/bin/bash

echo "dropping logs" && \
rm /var/log/nginx/access.log /var/log/nginx/error.log && \
kill -USR1 `cat /var/run/nginx.pid`
