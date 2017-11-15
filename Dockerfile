FROM alpine:latest

MAINTAINER Félix Sanz <me@felixsanz.com>

RUN apk add --no-cache --upgrade --virtual .build-deps autoconf g++ gcc git make \
  && apk add --no-cache libstdc++ \
  && mkdir -p /usr/src/ssdb \
  && git clone --depth 1 https://github.com/ideawu/ssdb.git /usr/src/ssdb \
  && make -C /usr/src/ssdb \
  && make -C /usr/src/ssdb install \
  && rm -rf /usr/src/ssdb
  && apk del .build-deps

COPY ssdb.conf /usr/local/ssdb/ssdb.conf

EXPOSE 8888

RUN mkdir /data /logs

VOLUME /data /logs

WORKDIR /data

CMD ["/usr/local/ssdb/ssdb-server", "/usr/local/ssdb/ssdb.conf"]
