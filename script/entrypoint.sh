#!/bin/sh

# start nginx
nginx

# make initial db pull
/srv/update.sh || exit 1

# infinite loop to keep container running
while true; do
 sleep 1
done
