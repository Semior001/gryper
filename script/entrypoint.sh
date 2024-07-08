#!/bin/sh

# start nginx
nginx

# make initial db pull
/srv/update.sh

# infinite loop to keep container running
while true; do
 sleep 1
done
