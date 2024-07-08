#!/bin/sh

echo "will be published at $PUBLISH_BASE_URL"
echo "$PUBLISH_BASE_URL" > /srv/publish-base-url

# start nginx
nginx

# make initial db pull
/srv/update.sh || exit 1

# infinite loop to keep container running
crond -f -L /srv/cron.log
