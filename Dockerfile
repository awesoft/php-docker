ARG PHP_VERSION=8.4
ARG COMPOSER_VERSION=2.8

FROM composer:${COMPOSER_VERSION} AS composer-stage
FROM php:${PHP_VERSION}-fpm-alpine AS php-stage

RUN apk add --no-cache $PHPIZE_DEPS \
        zip \
        linux-headers \
        build-base \
        libsodium-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        freetype-dev \
        giflib-dev \
        libwebp-dev \
        libavif-dev \
        zlib-dev \
        oniguruma-dev \
        libzip-dev \
        gettext-dev \
        icu-dev \
        tidyhtml-dev \
        libxslt-dev \
        gmp-dev \
        openssl-dev \
    && pecl install \
        xdebug \
        redis \
        pcov \
    && docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp --with-avif \
    && docker-php-ext-install -j$(nproc) \
        bcmath \
        bz2 \
        calendar \
        exif \
        ftp \
        gd \
        gettext \
        gmp \
        intl \
        mysqli \
        pdo_mysql \
        shmop \
        soap \
        sodium \
        sockets \
        sysvmsg \
        sysvsem \
        sysvshm \
        tidy \
        xsl \
        zip \
        pcntl \
        $( [ "$(echo $PHP_VERSION | cut -d. -f1,2 | tr -d .)" -lt 85 ] && echo opcache ) \
    && docker-php-ext-enable \
        xdebug \
        redis \
        pcov

FROM php:${PHP_VERSION}-fpm-alpine

ENV PS1="\u@\h:\w$ "
ENV HISTFILE="/tmp/.bash_history"
ENV COMPOSER_HOME="/.composer"
ENV COMPOSER_MEMORY_LIMIT=-1

RUN apk add --no-cache \
        libsodium \
        libjpeg-turbo \
        libpng \
        freetype \
        giflib \
        libwebp \
        libavif \
        cronie \
        zlib \
        oniguruma \
        libzip \
        gettext \
        icu \
        tidyhtml \
        libxslt \
        gmp \
        zip \
        unzip \
        openssl

COPY --from=php-stage /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini
COPY --from=php-stage /usr/local/lib/php/extensions/ /usr/local/lib/php/extensions/
COPY --from=php-stage /usr/local/etc/php/conf.d/ /usr/local/etc/php/conf.d/
COPY --from=composer-stage --chmod=755 /usr/bin/composer /usr/bin/composer
COPY --chown=root:root --chmod=755 bin/ /usr/local/bin/
COPY --chown=root:root --chmod=755 bin/docker-entrypoint /docker-entrypoint.sh
COPY --chown=root:root --chmod=755 etc/www.conf /usr/local/etc/php-fpm.d/www.conf

RUN adduser -u 1000 -D -h /app -s /bin/sh app app \
    && mkdir -p /usr/local/etc/php/extensions/ \
    && mv /usr/local/etc/php/conf.d/docker-php-ext-*.ini /usr/local/etc/php/extensions/ \
    && chmod -R 775 /usr/local/etc/php/conf.d \
    && chown -R root:app /usr/local/etc/php/conf.d

WORKDIR /app

CMD ["php", "-v"]

ENTRYPOINT ["/docker-entrypoint.sh"]
