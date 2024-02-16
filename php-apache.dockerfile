ARG PHP_VERSION
FROM php:$PHP_VERSION-apache

ARG UID
ARG GID

ENV UID=${UID}
ENV GID=${GID}

ARG USERNAME=application

RUN apt-get update && apt-get upgrade -y

RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli
RUN apt-get install -y libzip-dev zip && docker-php-ext-install zip
RUN docker-php-ext-install pdo pdo_mysql

RUN apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libjpeg-dev libpng-dev libgmp-dev

RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd

RUN apt-get install -y vim
RUN apt-get install -y git 

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

RUN a2enmod rewrite
RUN a2ensite default-ssl
RUN a2enmod ssl

EXPOSE 80
EXPOSE 443

RUN addgroup --system --gid $GID $USERNAME
RUN adduser --system --gid $GID --shell /bin/bash --uid $UID $USERNAME

USER $UID:$GID