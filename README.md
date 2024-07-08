# gryper
all-in-one grype-db + nginx container for serving grype listing for nvd &amp; github advisory databases

## usage
```bash
docker run -d \
      --name gryper \
      -p 8080:8080 \
      -v ./build:/build \
      -v ./.vunnel.yaml:/srv/.vunnel.yaml \
      -v ./data:/data \
      ghcr.io/semior001/gryper
```

or copy the `docker-compose.yml` file and run `docker-compose up -d`
