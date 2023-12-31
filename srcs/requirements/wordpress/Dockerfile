# syntax=docker/dockerfile:1

# https://docs.docker.com/engine/reference/builder/
# https://developer.wordpress.org/advanced-administration/before-install/howto-install/
FROM debian:bullseye

ARG DOMAIN_NAME

ARG MARIA_DB
ARG MARIA_USER
ARG MARIA_USER_PWD
ARG MARIA_ROOT_PWD

ARG WP_TITLE
ARG WP_ADMIN_USER
ARG WP_ADMIN_PWD
ARG WP_ADMIN_EMAIL

ARG WP_USER_LOGIN
ARG WP_USER_PWD
ARG WP_USER_EMAIL

WORKDIR /app

# WordPress CLI doc
# https://make.wordpress.org/cli/handbook/how-to/how-to-install/
# installation of php, php-fpm (fastCGI Manager), php-mysql and ofc wordpress

RUN apt-get update -yq \
&& apt-get upgrade -yq \
&& apt-get install -yq wget \
&& apt-get install -y php7.4 php-fpm php-mysql mariadb-client \
&& wget -q https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
&& chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp \
&& mkdir -p /run/php

COPY /conf/www.conf /etc/php/7.4/fpm/pool.d/
COPY ./conf/wp-config.php /app/wordpress/wp-config.php
COPY ./conf/wp_install.sh /my_scripts/

RUN chmod 777 /my_scripts/wp_install.sh \
&& wp core download --path=./wordpress --version=6.3 --allow-root

#&& wget -q https://wordpress.org/wordpress-6.3.tar.gz \
#&& tar -xzf wordpress-6.3.tar.gz && rm wordpress-6.3.tar.gz \
#&& chown -R root:root /app/wordpress \

ENTRYPOINT ["/my_scripts/wp_install.sh"]

# options for the tar command above
# -x to extract -z to use gzip -f to choose the archive file