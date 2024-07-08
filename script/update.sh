#!/bin/sh

/usr/local/bin/grype-db -c /srv/grypedb.yaml pull
/usr/local/bin/grype-db -c /srv/grypedb.yaml build
/usr/local/bin/grype-db -c /srv/grypedb.yaml package
