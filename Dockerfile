FROM alpine AS builder

RUN apk add --update --no-cache  build-base openssl-dev

# Get LIVE555 Media Server source code
RUN cd /tmp/ && \
  wget http://www.live555.com/liveMedia/public/live555-latest.tar.gz && \
  tar zxf live555-latest.tar.gz && rm live555-latest.tar.gz

# Compile LIVE555 Proxy Server
RUN cd /tmp/live && \
  ./genMakefiles linux && \
  make && make install && make distclean

FROM alpine
RUN apk add --update --no-cache gcc
COPY --from=builder /usr/local/bin/live555ProxyServer /usr/local/bin/

EXPOSE 554
EXPOSE 8554

CMD ["live555ProxyServer"]
