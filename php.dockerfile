ARG PHP_VERSION
FROM php:$PHP_VERSION-fpm-alpine

RUN mkdir -p /var/www/html

WORKDIR /var/www/html

# install opcache
RUN docker-php-ext-install opcache

# install composer
COPY --from=composer:lts /usr/bin/composer /usr/bin/composer

# install npm
# RUN apk add --no-cache nodejs npm

# install pdo
# RUN docker-php-ext-install pdo pdo_mysql

# install pgsql
# RUN apk add --no-cache libpq-dev \
#     && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
#     && docker-php-ext-install pdo pdo_pgsql pgsql \
#     && apk del libpq-dev

# install zip
# RUN apk add --no-cache zip libzip-dev
# RUN docker-php-ext-configure zip
# RUN docker-php-ext-install zip

# install exif
# RUN docker-php-ext-configure exif
# RUN docker-php-ext-install exif
# RUN docker-php-ext-enable exif

# install gd
# RUN apk add --no-cache freetype-dev libpng libpng-dev jpeg-dev libjpeg-turbo-dev \
#     && docker-php-ext-configure gd --with-jpeg --with-freetype \
#     && docker-php-ext-install gd \
#     && docker-php-ext-enable gd \
#     && apk del libpng-dev

# install intl
# RUN apk add --no-cache icu-dev \ 
#     && docker-php-ext-configure intl \ 
#     && docker-php-ext-install intl

# install redis
# RUN mkdir -p /usr/src/php/ext/redis \
#     && curl -L https://github.com/phpredis/phpredis/archive/5.3.4.tar.gz | tar xvz -C /usr/src/php/ext/redis --strip 1 \
#     && echo 'redis' >> /usr/src/php-available-exts \
#     && docker-php-ext-install redis

# Install mariadb client
# RUN apk add --update --no-cache mysql-client

CMD ["php-fpm", "-y", "/usr/local/etc/php-fpm.conf", "-R"]
