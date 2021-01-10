# LIVE555 Proxy Server for Docker
Automated build of [LIVE555 Proxy Server](http://www.live555.com/proxyServer/).

The "LIVE555 Proxy Server" is a unicast RTSP server - built from the ["LIVE555 Streaming Media" software](http://www.live555.com/liveMedia/) - that acts as a 'proxy' for one or more 'back-end' unicast or multicast RTSP/RTP streams (i.e., served by other server(s)).

The key feature of a proxy server is that it reads each 'back-end' stream only once, regardless of how many separate clients are streaming from the proxy server. This makes the proxy server ideal, for example, for streaming from a RTSP-enabled video camera (which might not be able to handle more than one connection at a time).
```
                                                      --> [RTSP client1]
[back-end RTSP/RTP stream] --> [LIVE555 Proxy Server] --> [RTSP client2]
                                                      ...
                                                      --> [RTSP clientN]
```

# Usage
Provide the RTSP urls to your Docker container as the command property.

A single back-end stream will be proxied to the endpoint ```rtsp://hostname:[554|8554]/proxyStream```

Multiple back-end streams will be proxied to corresponding endpoints ```rtsp://hostname/proxyStream-1```, ```rtsp://hostname:[554|8554]/proxyStream-2```, ..., ```rtsp://hostname:[554|8554]/proxyStream-n```

Here are some example snippets to help you get started creating a container.

**docker-compose**
```
version: '2'
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
```
docker run -d \
  --name=live555-proxy-server \
  --net=host \
  --restart unless-stopped \
  paradisi/live555-proxy-server
  -v <url1> <url2>
  ```
