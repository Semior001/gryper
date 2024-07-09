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

Example .vunnel.yaml, it is important to leave root directory as `/data`, as it is hardcoded in the image:
```yaml
root: /data

log:
  level: trace
  show_level: true
  show_timestamp: true

providers:
  nvd:
    api_key: '<your api key here>'
    overrides_enabled: false
    request_timeout: 125
    runtime:
      existing_input: keep
      existing_results: keep
      import_results_enabled: false
      import_results_host: ''
      import_results_path: providers/{provider_name}/listing.json
      on_error:
        action: fail
        input: keep
        results: keep
        retry_count: 3
        retry_delay: 5
      result_store: sqlite
      skip_newer_archive_check: false
  github:
    token: '<your api key here>'
    api_url: https://api.github.com/graphql
    request_timeout: 125
    runtime:
      existing_input: keep
      existing_results: delete-before-write
      import_results_enabled: false
      import_results_host: ''
      import_results_path: providers/{provider_name}/listing.json
      on_error:
        action: fail
        input: keep
        results: keep
        retry_count: 3
        retry_delay: 5
      result_store: sqlite
      skip_newer_archive_check: false
```
I
