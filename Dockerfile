FROM balenalib/raspberrypi3-alpine:latest-build AS builder

RUN [ "cross-build-start" ]

RUN install_packages openssl-dev

# Get Live555 source
RUN cd /tmp/ && \
  wget http://www.live555.com/liveMedia/public/live555-latest.tar.gz && \
  tar zxf live555-latest.tar.gz && rm live555-latest.tar.gz

# Compile Live555 Proxy Server
RUN cd /tmp/live && \
  ./genMakefiles linux && \
  make && make install && make distclean

RUN [ "cross-build-end" ]

FROM balenalib/raspberrypi3-alpine:latest-run
RUN install_packages gcc
COPY --from=builder /usr/local/bin/live555ProxyServer /usr/local/bin/

EXPOSE 554
EXPOSE 8554

ENTRYPOINT ["live555ProxyServer"]
