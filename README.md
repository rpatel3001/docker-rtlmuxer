# docker-rtlmuxer
Proxy rtl_tcp compatible streams to allow for multiple clients.

This container is a thin wrapper around [rpatel3001/rtlmuxer](https://github.com/rpatel3001/rtlmuxer), which is a slightly modified fork of [alexander-sholohov/rtlmuxer](https://github.com/alexander-sholohov/rtlmuxer).

## Docker Compose Snippet

```
  rtlmuxer:
    container_name: rtlmuxer
    hostname: rtlmuxer
    image: ghcr.io/rpatel3001/docker-rtlmuxer
    restart: always
    ports:
      - 7373:7373
      - 7374:7374
    volumes:
      - /etc/timezone:/etc/timezone:ro
      - /etc/localtime:/etc/localtime:ro
    environment:
      - SRC_ADDR=x.x.x.x
```

## Configuration options

| Variable | Description | Default |
|----------|-------------|---------|
| `SRC_ADDR` | Address of the rtl_tcp source we are proxying. | Unset |
| `SRC_PORT` | Port of the rtl_tcp source we are proxying. | 1234 |
| `SINK_ADDR` | Address to bind for the proxied connections. | 0.0.0.0 |
| `RW_SINK_PORT` | Port to bind for the read/write proxy connection. | 7373 |
| `RO_SINK_PORT` | Port to bind for the read-only proxy connection. | 7374 |