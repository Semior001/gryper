#!/bin/sh

# set PUBLISH_BASE_URL to the content of /srv/publish-base-url
export PUBLISH_BASE_URL=$(cat /srv/publish-base-url)

/usr/local/bin/grype-db -c /srv/grypedb.yaml pull && \
/usr/local/bin/grype-db -c /srv/grypedb.yaml build && \
/usr/local/bin/grype-db -c /srv/grypedb.yaml -u $PUBLISH_BASE_URL package && \
chown -R nginx:nginx /build || exit 1
