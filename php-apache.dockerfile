ARG PHP_VERSION
FROM php:$PHP_VERSION-apache

ARG UID
ARG GID

ENV UID=${UID}
ENV GID=${GID}

ARG USERNAME=application

RUN apt-get update && apt-get upgrade -y

# mysqli php extension
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli

# zip php extension
RUN apt-get install -y libzip-dev zip && docker-php-ext-install zip

# pdo mysql php extension
RUN docker-php-ext-install pdo pdo_mysql

# gd php extension
RUN apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libjpeg-dev libpng-dev libgmp-dev
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd

# install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# config root dir
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# enable ssl
RUN a2enmod rewrite
RUN a2ensite default-ssl
RUN a2enmod ssl

# expose port
EXPOSE 80
EXPOSE 443

RUN addgroup --system --gid $GID $USERNAME
RUN adduser --system --gid $GID --shell /bin/bash --uid $UID $USERNAME

USER $UID:$GID