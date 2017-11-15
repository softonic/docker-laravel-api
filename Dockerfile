# Use official php image with fpm using alpine.
FROM php:7.1-fpm-alpine

ARG "version=3.0-dev"
ARG "build_date=unknown"
ARG "commit_hash=unknown"
ARG "vcs_url=unknown"
ARG "vcs_branch=unknown"

LABEL org.label-schema.vendor="Softonic" \
    org.label-schema.name="laravel-api" \
    org.label-schema.description="PHP-FPM Docker image extension to use with Laravel APIs" \
    org.label-schema.usage="/src/README.md" \
    org.label-schema.url="https://github.com/softonic/docker-laravel-api/blob/master/README.md" \
    org.label-schema.vcs-url=$vcs_url \
    org.label-schema.vcs-branch=$vcs_branch \
    org.label-schema.vcs-ref=$commit_hash \
    org.label-schema.version=$version \
    org.label-schema.schema-version="1.0" \
    org.label-schema.docker.cmd.devel="" \
    org.label-schema.build-date=$build_date

# Installing required dependencies of laravel project.
RUN apk update &&\
    apk add autoconf\
        g++\
        make \
        zlib-dev \
        libxml2-dev \
        fcgi \
        git \
        bash \
    && docker-php-ext-install zip \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install bcmath \
    && docker-php-ext-install opcache \
    && docker-php-ext-install pdo_mysql \
    && apk del autoconf g++ make \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

RUN composer global require "hirak/prestissimo:^0.3"

# Copy php.ini configuration to use in php-fpm
ADD ./docker/php-fpm/rootfs /

# Set Working directory
WORKDIR /opt/app/

ENTRYPOINT ["/start.sh"]

CMD ["php-fpm"]
