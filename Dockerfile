FROM php:8.3.9-cli

RUN apt update

ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN install-php-extensions ds zip intl xdebug-3.3.2 raphf http

RUN install-php-extensions @composer

ENV PROJECT_ROOT="/opt/project"

EXPOSE 9003
