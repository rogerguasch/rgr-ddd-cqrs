FROM composer:latest as composer

FROM php:8.0.6-fpm

WORKDIR /app

RUN apt-get update && apt-get install -y openssl wget  \
    autoconf automake bash make gcc g++ argon2 zip libzip-dev libonig-dev \
    && pecl install apcu-5.1.18 \
    && pecl install xdebug-3.0.4 \
    && docker-php-ext-install opcache mysqli pdo pdo_mysql zip bcmath sockets mbstring \
    && docker-php-ext-enable opcache apcu xdebug

COPY --from=composer /usr/bin/composer /usr/bin/composer
COPY docker/php/config /usr/local/etc/php/conf.d/

RUN sed -i "1 i\zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN sed -i "1 i\zend_extension=$(find /usr/local/lib/php/extensions/ -name opcache.so)" /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini

RUN curl -sS https://get.symfony.com/cli/installer | bash && mv /root/.symfony/bin/symfony /usr/local/bin/symfony

RUN printf '[PHP]\ndate.timezone = "Europe/Madrid"\n' > /usr/local/etc/php/conf.d/tzone.ini
