# syntax=docker/dockerfile:1

# parser directives at the very top of the Dockerfile.
# here it set the Dockerfile syntax to the latest version.

# Dockerfile reference doc :
# https://docs.docker.com/engine/reference/builder/

# parent image of the actual penultimate stable version of debian
FROM debian:bullseye

# apt, while being more "user-friendly", is less suited for script than apt-get
# trying to call RUN a minimum amount of time to reduce the quantity of docker layers
# each RUN instruction creates a new "layer"

RUN apt-get update -yq \
&& apt-get install nginx -yq \
&& apt-get install openssl -yq \
&& apt-get clean -y \
&& apt-get upgrade -y \
&& mkdir /etc/nginx/sslcerts \
&& openssl req -nodes -x509 -newkey rsa:2048 \
	-keyout /etc/nginx/sslcerts/key.pem \
	-out /etc/nginx/sslcerts/cert.pem \
	-subj "/C=FR/ST=Loiret/L=Montargis/O=42/OU=Quentin/CN=mravera"

# swap nginx default configuration file with our file
COPY conf/nginx.conf /etc/nginx/conf.d/.

# start nginx using the directive "daemon off" as an option to keep the program from self-daemonizing
# CMD does not execute anything at build time, but specifies the intended command for the image.
CMD ["nginx", "-g", "daemon off;"]

# openssl options :
# req		request the creation of a certificate
# -noenc	the created private key will not be encrypted (no "choose psswrd" prompt)
# -nodes	same as -noenc but deprecated in 3.0
# -x509		output a selfsigned certificate (no need for Certificate Authority)
# -sha256	only appear in the 1.0 doc as -[digest] command.
#			specifies the message digest to sign the request with.
# -newkey	create a new certificate with (in this case) a 2048 bits rsa private key
# -keyout	to choose name and folder of the key
# -out		to choose name and folder of the certificate
# -subj		to enter directly the subject info avoiding any prompt

# troubleshouting :
#
#	=> => # Err:1 http://deb.debian.org/debian buster InRelease
#	=> => #   Temporary failure resolving 'deb.debian.org'
#
# use one of these to restart docker :	sudo service docker restart
#										sudo /etc/init.d/docker restart
#										sudo snap restart docker

