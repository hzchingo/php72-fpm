FROM php:7.2-fpm-alpine

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
    && apk add libzip libbz2 libjpeg-turbo libpng libxslt freetype \
    && apk add --no-cache --virtual .build-deps freetype-dev libpng-dev \
    libjpeg-turbo-dev libxslt-dev bzip2-dev php7-dev libzip-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-configure zip --with-libzip \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && docker-php-ext-install -j$(nproc) gd bcmath xsl zip bz2 

RUN apk del .build-deps
