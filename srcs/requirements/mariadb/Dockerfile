# https://docs.docker.com/engine/reference/builder/
# "oldstable" debian version
FROM debian:bullseye

# to test without any ENV
ARG MARIA_ROOT_PWD=maria_root_pwd
ARG MARIA_DB=maria_db
ARG MARIA_USER=maria_user
ARG MARIA_PWD=maria_pwd

# -q for quiet
RUN apt-get update -yq \
&& apt-get upgrade -y \
&& apt-get install mariadb-server -y \
&& apt-get clean -y 

# copy our own configuration file into the container folder
COPY conf/my_conf.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# mariadb setup, here or in a separate script. more info in mariadb_start.sh file
# https://dev.mysql.com/doc/refman/8.0/en/account-names.html -> more info on account names and the use of 'user_name'@'%'
# -> Account name default syntax is = 'user_name'@'host_name'
# https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html#priv_grant-option -> more info on privileges

RUN service mariadb start \
# next line just to test without using ARG directives
# (must be in the same RUN directive since each RUN will create another different layer, forgetting other export things)
#&& export MARIA_ROOT_PWD=maria_root_pwd MARIA_DB=maria_db MARIA_PWD=maria_pwd MARIA_USER=maria_user \
&& sleep 5 \
# how to reset (or in our case set) root password -> http://dev.mysql.com/doc/refman/5.7/en/resetting-permissions.html
&& mariadb -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIA_ROOT_PWD}';" \
&& mariadb -u root -p"${MARIA_ROOT_PWD}" -e "CREATE DATABASE IF NOT EXISTS \`${MARIA_DB}\`;" \
&& mariadb -u root -p"${MARIA_ROOT_PWD}" -e "CREATE USER IF NOT EXISTS \`${MARIA_USER}\`@'localhost' IDENTIFIED BY '${MARIA_PWD}';" \
&& mariadb -u root -p"${MARIA_ROOT_PWD}" -e "GRANT ALL ON \`${MARIA_DB}\`.* TO \`${MARIA_USER}\`@'%' IDENTIFIED BY '${MARIA_PWD}';" \
&& mariadb -u root -p"${MARIA_ROOT_PWD}" -e "FLUSH PRIVILEGES;" \
&& mariadb-admin -u root -p"${MARIA_ROOT_PWD}" shutdown
# && service mariadb stop

# comment this to be able to use interactive (-it) docker option mode
CMD ["mysqld_safe"]
