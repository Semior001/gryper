#!/bin/sh

# pull, build, and package the grype database, and set the owner to nginx

/usr/local/bin/grype-db -c /srv/grypedb.yaml pull && \
/usr/local/bin/grype-db -c /srv/grypedb.yaml build && \
/usr/local/bin/grype-db -c /srv/grypedb.yaml package && \
chown -R nginx:nginx /build || exit 1
