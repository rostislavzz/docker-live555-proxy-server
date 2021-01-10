# docker-live555-proxy-server
Automated build of [LIVE555 Proxy Server](http://www.live555.com/proxyServer/).

# Usage
Here are some example snippets to help you get started creating a container.

**docker-compose**
```version: '2'
services:
  live555-proxy-server:
    image: paradisi/live555-proxy-server
    container_name: live555-proxy-server
    network_mode: host
    ports:
      - 554:554
      - 8554:8554
    command: -v <url1> <url2>
    restart: unless-stopped
```

**docker cli**
```docker run -d \
  --name=live555-proxy-server \
  --net=host \
  --restart unless-stopped \
  paradisi/live555-proxy-server
  <url1> <url2>
  ```
