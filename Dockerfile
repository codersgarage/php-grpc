FROM php:8.3.19-fpm-alpine

RUN apk add --no-cache \
    bsd-compat-headers \
    gcc \
    g++ \
    make \
    linux-headers \
    build-base \
    autoconf\
    zlib-dev
RUN apk add --no-cache \
    grpc
RUN MAKEFLAGS="-j $(nproc)" pecl install grpc
RUN docker-php-ext-enable grpc
RUN rm -rf /var/cache/apk/*
RUN find /usr/local/lib/php/extensions/ -exec strip {} \;
