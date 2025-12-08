FROM php:8.4.5-fpm-alpine

RUN apk add --no-cache \
    bsd-compat-headers \
    gcc \
    g++ \
    make \
    linux-headers \
    build-base \
    autoconf\
    zlib-dev \
    libstdc++ \
    brotli-dev
RUN apk add --no-cache \
    grpc
RUN MAKEFLAGS="-j $(nproc)" pecl install grpc redis swoole
RUN docker-php-ext-enable grpc redis.so swoole
RUN rm -rf /var/cache/apk/*
RUN find /usr/local/lib/php/extensions/ -exec strip {} \;
