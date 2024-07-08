FROM alpine:latest as base

RUN apk add --no-cache --update git bash curl py3-pip nginx && \
    rm -rf /var/cache/apk/*

RUN curl -sSfL https://raw.githubusercontent.com/anchore/grype-db/main/install.sh | \
    sh -s -- -b /usr/local/bin && \
    pip install --break-system-packages vunnel

COPY config/crontab       /var/spool/cron/crontabs/root
COPY config/grypedb.yaml  /srv/grypedb.yaml
COPY script/update.sh     /srv/update.sh
COPY script/entrypoint.sh /srv/entrypoint.sh
COPY config/nginx.conf    /etc/nginx/nginx.conf

RUN chmod 0644 /var/spool/cron/crontabs/root && \
    chmod +x /srv/update.sh && \
    chmod +x /srv/entrypoint.sh

RUN mkdir -p /run/nginx && \
    mkdir -p /var/lib/nginx && \
    mkdir -p /var/log/nginx && \
    mkdir -p /build

WORKDIR /srv
HEALTHCHECK --interval=5m --timeout=3s \
  CMD curl -f http://localhost:8080/ping || exit 1
EXPOSE 8080

# mount the /data, /build, /srv/.vunnel.yaml
# first two mounts are for the data and build directories

ENTRYPOINT ["/srv/entrypoint.sh"]
