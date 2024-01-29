ARG PHP_VERSION
FROM php:$PHP_VERSION-fpm-alpine

ARG UID
ARG GID

ENV UID=${UID}
ENV GID=${GID}

RUN mkdir -p /var/www/html

WORKDIR /var/www/html

# MacOS staff group's gid is 20, so is the dialout group in alpine linux. We're not using it, let's just remove it.
RUN delgroup dialout

RUN addgroup -g ${GID} --system application
RUN adduser -G application --system -D -s /bin/sh -u ${UID} application

RUN sed -i "s/user = www-data/user = application/g" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "s/group = www-data/group = application/g" /usr/local/etc/php-fpm.d/www.conf
RUN echo "php_admin_flag[log_errors] = on" >> /usr/local/etc/php-fpm.d/www.conf

# install opcache
RUN docker-php-ext-install opcache

# install git
# RUN apk add --no-cache git

# install composer
COPY --from=composer:lts /usr/bin/composer /usr/bin/composer

# install npm
# RUN apk add --no-cache nodejs npm

# install pdo
# RUN docker-php-ext-install pdo pdo_mysql

# insatll mysqli php ext
# RUN docker-php-ext-install mysqli \
#     && docker-php-ext-enable mysqli

# install mysql php ext
# RUN docker-php-ext-install mysql \
#     && docker-php-ext-enable mysql

# install pgsql 
# RUN apk add --no-cache libpq-dev \
#     && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
#     && docker-php-ext-install pdo pdo_pgsql pgsql

# install pgsql (php 5)
# RUN set -ex \
#     && apk --no-cache add postgresql-libs postgresql-dev \
#     && docker-php-ext-install pdo pgsql pdo_pgsql \
#     && apk del postgresql-dev

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

# install gd (php 5)
# RUN apk add --no-cache freetype-dev libpng libpng-dev jpeg-dev libjpeg-turbo-dev \
#     && docker-php-ext-configure gd --enable-gd-native-ttf --with-jpeg-dir=/usr/include/ --with-freetype-dir=/usr/include/ \
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

USER ${UID}:${GID}

CMD ["php-fpm", "-y", "/usr/local/etc/php-fpm.conf", "-R"]
