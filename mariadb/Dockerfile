FROM debian:bookworm


LABEL authors="paul.depetrini@gmail.com"
RUN apt-get update

RUN apt-get install -y mariadb-server
COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf
COPY conf/script.sh /scripts/script.sh
RUN chmod +x /scripts/script.sh
ENTRYPOINT [ "/scripts/script.sh" ]




# https://www.gekkode.com/developpement/installation-de-mariadb-et-phpmyadmin/
# https://www.it-connect.fr/installer-phpmyadmin-sur-debian-11-et-apache/

