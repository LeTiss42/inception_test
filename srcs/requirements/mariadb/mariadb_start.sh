#!/bin/bash

# script bash to start mariadb service and setup the database
# this can be done directly by hand through MariaDB monitor, for exemple :
# $mariadb -u root -p to start         the MariaDB monitor
# $SELECT user FROM mysql.user;        to display all user
# $exit;                               to exit MariaDB monitor
# but here we use a bash script to do it by itself

service mariadb start

# sleep 5 seconds to wait for other containers to start correctly
sleep 5

# we run MySQL commands via bash (here with mariadb) -> mariadb --help
# -u user for login if not current user
# -p to specify the password and avoid prompt
# -e to execute the command and quit
mariadb -u root -p"${MARIA_ROOT_PWD}" -e "CREATE DATABASE IF NOT EXISTS \`${MARIA_DB}\`;"
mariadb -u root -p"${MARIA_ROOT_PWD}" -e "CREATE USER IF NOT EXISTS \`${MARIA_USER}\`@'localhost' IDENTIFIED BY '${MARIA_PWD}';"
mariadb -u root -p"${MARIA_ROOT_PWD}" -e "GRANT ALL PRIVILEGES ON \`${MARIA_DB}\`.* TO \`${MARIA_USER}\`@'%' IDENTIFIED BY '${MARIA_PWD}';"
# is next line really necessary?
mariadb -u root -p"${MARIA_ROOT_PWD}" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIA_ROOT_PWD}';"
mariadb -u root -p"${MARIA_ROOT_PWD}" -e "FLUSH PRIVILEGES;"

# mariadb-admin is an administration program for the mysqld daemon
mariadb-admin -u root -p"${MARIA_ROOT_PWD}" shutdown

# The mysqld_safe (or mariadb-safe but did not work here) startup script is in MariaDB distributions on Linux and Unix.
# It is a wrapper that starts mysqld with some extra safety features suche as restarting the server when an error occurs.
# The script sets environment variables and checks for errors before launching the MySQL server.
exec mysqld_safe

# STOP the mariadb service using the command :
# service mariadb stop
# enter a running container in a new console by using :
# docker exec -it [container-id] bash
