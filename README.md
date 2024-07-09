# gryper
all-in-one grype-db + nginx container for serving grype listing for nvd &amp; github advisory databases

## usage
```bash
docker run -d \
      -e PUBLISH_BASE_URL="https://test.semior.dev" \
      --name gryper \
      -p 8080:8080 \
      -v ./build:/build \
      -v ./.vunnel.yaml:/srv/.vunnel.yaml \
      -v ./data:/data \
      ghcr.io/semior001/gryper
```

or copy the `docker-compose.yml` file and run `docker-compose up -d`

You can optionally mount: 
- `-v ./cron.log:/srv/cron.log` to see logs of the crond, when it fetches the databases;
- `-v ./access.log:/var/log/nginx/access.log` and `-v ./error.log:/var/log/nginx/error.log` to see the nginx logs;

Image polls nvd and github advisory every 3 hours.
