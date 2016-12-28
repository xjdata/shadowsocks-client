FROM alpine:3.4
MAINTAINER xjdata , <xjdata@gmail.com>

ENV SS_VER 2.5.6
ENV SS_URL https://github.com/shadowsocks/shadowsocks-libev/archive/v$SS_VER.tar.gz
ENV SS_DIR shadowsocks-libev-$SS_VER


RUN set -ex \
    && apk add --no-cache pcre \
    && apk add --no-cache \
               --virtual TMP autoconf \
                             build-base \
                             curl \
                             libtool \
                             linux-headers \
                             openssl-dev \
                             pcre-dev \
    && curl -sSL $SS_URL | tar xz \
    && cd $SS_DIR \
        && ./configure --disable-documentation \
        && make install \
        && cd .. \
        && rm -rf $SS_DIR \
    && apk del --virtual TMP

ENV SERVER_ADDR www.google.com
ENV SERVER_PORT 443
ENV LOCAL_ADDR  127.0.0.1
ENV LOCAL_PORT  1080
ENV METHOD      aes-256-cfb
ENV PASSWORD    helloworld
ENV TIMEOUT     60


EXPOSE $LOCAL_PORT

CMD ss-local  -s "$SERVER_ADDR" \
              -p "$SERVER_PORT" \
              -b "$LOCAL_ADDR"  \
              -l "$LOCAL_PORT"  \
              -m "$METHOD"      \
              -k "$PASSWORD"    \
              -t "$TIMEOUT"     \
              -u                \
              #-A                \
              --fast-open
