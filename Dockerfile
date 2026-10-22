FROM php:8.4.27-fpm-alpine

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
RUN php -r 'if (PHP_VERSION !== "8.4.27") { fwrite(STDERR, "Unexpected PHP version: " . PHP_VERSION . PHP_EOL); exit(1); } foreach (["grpc", "redis", "swoole"] as $extension) { if (!extension_loaded($extension)) { fwrite(STDERR, "Missing extension: " . $extension . PHP_EOL); exit(1); } }'
RUN rm -rf /var/cache/apk/*
RUN find /usr/local/lib/php/extensions/ -exec strip {} \;
