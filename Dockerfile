FROM php:7.4-fpm

RUN apt-get update && apt-get install -y \
        mc \
        postgresql-client libpq-dev \
        libonig-dev \
        libzip-dev \
        php7.4-bcmath \
        git \
        curl \
        wget \
        libmcrypt-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev zlib1g-dev libicu-dev g++ libmagickwand-dev --no-install-recommends libxml2-dev \
    && docker-php-ext-configure intl \
    && docker-php-ext-configure gd \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install intl \
    && docker-php-ext-install -j$(nproc) mbstring zip xml  pdo_mysql pdo_pgsql \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && docker-php-ext-install opcache \
    && docker-php-ext-install bcmath

RUN wget https://getcomposer.org/installer -O - -q \
    | php -- --install-dir=/bin --filename=composer --quiet
