# you can change the version of php
FROM php:7.2-fpm-alpine

WORKDIR /var/www

# install php extensions
RUN docker-php-ext-install pdo pdo_mysql

# install composer
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

RUN chown -R www-data:www-data /var/www