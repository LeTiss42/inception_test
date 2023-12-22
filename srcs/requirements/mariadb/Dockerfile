# syntax=docker/dockerfile:1

# https://docs.docker.com/engine/reference/builder/
# "oldstable" debian version
FROM debian:bullseye

ARG MARIA_DB=maria_db
ARG MARIA_USER=maria_user
ARG MARIA_PWD=maria_pwd
ARG MARIA_ROOT_PWD=maria_root_pwd 

# -q for quiet
RUN apt-get update -yq \
&& apt-get upgrade -y \
&& apt-get install mariadb-server -y \
&& apt-get clean -y 

# Copy the configuration file we want to use into the container folder
COPY conf/my_conf.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Wordpress tuto page to install a database :
# https://developer.wordpress.org/advanced-administration/before-install/creating-database/#using-the-mysql-client

# Mariadb setup, can be done here or in a separate script
# This can be done and should be done directly through MariaDB monitor to test if everything works as intended

# MariaDB monitor basic usage :
# :$mariadb -u root -p to start         the MariaDB monitor
# :$SELECT user FROM mysql.user;        to display all user
# :$exit;                               to exit MariaDB monitor

# More info on account names and the use of 'user_name'@'%' -> https://dev.mysql.com/doc/refman/8.0/en/account-names.html
# -> Account name default syntax is = 'user_name'@'host_name'
# more info on privileges https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html#priv_grant-option

# we run MySQL commands via bash (here with mariadb) -> mariadb --help
# -u user for login if not current user
# -p to specify the password and avoid prompt
# -e to execute the command and quit

RUN service mariadb start \
# Next line is here just to test without using the previous ARG directives
# (must be in the same RUN directive since each RUN will create another different layer, each new layer forgetting export from other layers)
#&& export MARIA_ROOT_PWD=maria_root_pwd MARIA_DB=maria_db MARIA_PWD=maria_pwd MARIA_USER=maria_user \
&& sleep 5 \
# how to reset (or in our case set) root password -> http://dev.mysql.com/doc/refman/5.7/en/resetting-permissions.html
&& mariadb -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIA_ROOT_PWD}';" \
&& mariadb -u root -p"${MARIA_ROOT_PWD}" -e "FLUSH PRIVILEGES;" \
&& mariadb -u root -p"${MARIA_ROOT_PWD}" -e "CREATE DATABASE IF NOT EXISTS \`${MARIA_DB}\`;" \
&& mariadb -u root -p"${MARIA_ROOT_PWD}" -e "CREATE USER IF NOT EXISTS \`${MARIA_USER}\`@'localhost' IDENTIFIED BY '${MARIA_PWD}';" \
&& mariadb -u root -p"${MARIA_ROOT_PWD}" -e "GRANT ALL PRIVILEGES ON \`${MARIA_DB}\`.* TO \`${MARIA_USER}\`@'localhost' IDENTIFIED BY '${MARIA_PWD}';" \
# ALL and ALL PRIVILEGES are equivalent, the word PRIVILEGES is optionnal here
&& mariadb -u root -p"${MARIA_ROOT_PWD}" -e "FLUSH PRIVILEGES;" \
# mariadb-admin is an administration program for the mysqld daemon
&& mariadb-admin -u root -p"${MARIA_ROOT_PWD}" shutdown

# comment this to be able to use interactive (-it) docker option mode
CMD ["mysqld_safe"]

# The mysqld_safe (or mariadb-safe but did not work here) startup script is in MariaDB distributions on Linux and Unix.
# It is a wrapper that starts mysqld with some extra safety features suche as restarting the server when an error occurs.
# The script sets environment variables and checks for errors before launching the MySQL server.