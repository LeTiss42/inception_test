# syntax=docker/dockerfile:1

# https://docs.docker.com/engine/reference/builder/
# https://developer.wordpress.org/advanced-administration/before-install/howto-install/
FROM debian:bullseye

WORKDIR /app

# installation of php, php-fpm (fastCGI Manager), php-mysql and ofc wordpress
#
RUN apt-get update -yq \
&& apt-get upgrade -yq \
&& apt-get install -yq wget \
&& wget -q https://wordpress.org/wordpress-6.3.tar.gz \
&& tar -xzf wordpress-6.3.tar.gz && rm wordpress-6.3.tar.gz \
&& chown -R root:root /app/wordpress

# && apt-get install -y php7.4 php-fpm php-mysql mariadb-client \

# options for the tar command above
# -x to extract -z to use gzip -f to choose the archive file