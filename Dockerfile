FROM php:8.2-fpm
ENV COMPOSER_VERSION=2.5.5
RUN apt-get update && apt-get install -y wget git
RUN wget https://getcomposer.org/download/${COMPOSER_VERSION}/composer.phar -O /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer \
    && composer --version

RUN apt-get update \
  && apt-get install -y \
             apt-utils \
             man \
             curl \
             git \
             bash \
             vim \
             zip unzip \
             acl \
             iproute2 \
             dnsutils \
             fonts-freefont-ttf \
             fontconfig \
             dbus \
             openssh-client \
             sendmail \
             libfreetype6-dev \
             libjpeg62-turbo-dev \
             icu-devtools \
             libicu-dev \
             libmcrypt4 \
             libmcrypt-dev \
             libpng-dev \
             zlib1g-dev \
             libxml2-dev \
             libzip-dev \
             libonig-dev \
             graphviz \
             libcurl4-openssl-dev \
             pkg-config \
             libldap2-dev \
             libpq-dev

RUN docker-php-ext-install pdo \
        mysqli pdo_mysql \
        intl iconv mbstring \
        zip pcntl \
        exif opcache gd \
    && docker-php-source delete

RUN pecl install -o -f redis \

&&  rm -rf /tmp/pear \
&&  docker-php-ext-enable redis

ENTRYPOINT ["./entrypoint.sh"]
