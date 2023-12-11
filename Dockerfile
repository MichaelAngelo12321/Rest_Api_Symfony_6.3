# Dockerfile

FROM php:8.2-apache

WORKDIR /var/www

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions
RUN install-php-extensions pdo_mysql intl opcache zip

COPY . .

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

COPY ./docker/vhost.conf /etc/apache2/sites-available/000-default.conf

ENTRYPOINT ["docker/entrypoint.sh"]