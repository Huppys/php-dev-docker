FROM php:8.3.6-cli

RUN pecl install ds

RUN pecl install xdebug-3.3.2 && \
    echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini &&  \
    echo "xdebug.mode = debug" >> /usr/local/etc/php/conf.d/xdebug.ini &&  \
    echo "xdebug.start_with_request = yes" >> /usr/local/etc/php/conf.d/xdebug.ini

RUN rm -rf /tmp/pear /tmp/pear-build-root

RUN apt update && \
    apt install -y git libzip-dev unzip libicu-dev

RUN docker-php-ext-install zip intl
RUN docker-php-ext-enable zip intl xdebug ds

COPY install-composer.sh /opt/src/composer/install-composer.sh
RUN chmod +x /opt/src/composer/install-composer.sh
RUN /opt/src/composer/install-composer.sh
RUN ln -nfs /usr/local/bin/composer.phar /usr/local/bin/composer

ENV PROJECT_ROOT="/opt/project"

EXPOSE 9003
