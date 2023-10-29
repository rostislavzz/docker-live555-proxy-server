FROM alpine AS builder
RUN apk add --update --no-cache build-base openssl-dev

# Get LIVE555 Media Server source code
RUN cd /tmp/ && \
  wget http://www.live555.com/liveMedia/public/live555-latest.tar.gz && \
  tar zxf live555-latest.tar.gz && rm live555-latest.tar.gz

# Building with C++ version 20
# http://lists.live555.com/pipermail/live-devel/2023-August/022380.html
RUN echo -e "CPPFLAGS = -std=c++20\r\n$(cat /tmp/live/config.linux)" > /tmp/live/config.linux

# Apply OutPacketBuffer::maxSize patch
COPY live555ProxyServer.patch /tmp
RUN patch /tmp/live/proxyServer/live555ProxyServer.cpp < /tmp/live555ProxyServer.patch

# Compile LIVE555 Proxy Server
RUN cd /tmp/live && ./genMakefiles linux && \
  make && make install && make distclean

FROM alpine
RUN apk add --update --no-cache libstdc++
COPY --from=builder /usr/local/bin/live555ProxyServer /usr/local/bin/

EXPOSE 554
EXPOSE 8554

ENTRYPOINT ["live555ProxyServer"]
