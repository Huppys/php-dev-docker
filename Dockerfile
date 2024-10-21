FROM php:8.3.12-cli

RUN apt update

ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN install-php-extensions ds zip intl xdebug-3.3.2

ENV XDEBUG_MODE=debug

COPY ./docker/conf/xdebug/99-xdebug.ini /usr/local/etc/php/conf.d/99-xdebug.ini

RUN install-php-extensions @composer

ENV PROJECT_ROOT="/opt/project"

WORKDIR /opt/project

EXPOSE 9003
