FROM php:7.4.13-apache
MAINTAINER Katsuyoshi Yabe <kay@wizis.com>

## Change user ID
run usermod www-data -u 1000
run groupmod www-data -g 1000

run apt update \
	&& apt install -y \
	gcc \
	make \
	git \
	unzip \
	vim \
	curl \
	gnupg \
	libfreetype6-dev \
	libjpeg62-turbo-dev \
	libmcrypt-dev \
	libpng-dev \
	zlib1g-dev \
	libxml2-dev \
	libzip-dev \
	libonig-dev \
	graphviz \
	libc-client-dev \
	libkrb5-dev \
	&& docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
	&& docker-php-ext-install imap \
	&& docker-php-ext-install pdo_mysql \
	&& docker-php-ext-install mysqli \
	&& docker-php-ext-install mbstring \
	&& docker-php-ext-install shmop \
	&& docker-php-ext-install zip \
	&& docker-php-ext-configure gd --with-freetype --with-jpeg \
	&& docker-php-ext-install gd \
	&& docker-php-source delete

run a2enmod rewrite
run a2enmod ssl

copy ./php.ini /usr/local/etc/php

## Install composer
workdir /usr/local/bin/
run curl -sS https://getcomposer.org/installer | php
run mv composer.phar composer

## Install postfix
env DEBIAN_FRONTEND=noninteractive
run apt install -y postfix

copy ./master.cf /etc/postfix
copy ./main.cf /etc/postfix

## Finalizing...
run apt clean
run rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

workdir /var/www
