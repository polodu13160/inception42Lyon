FROM debian:bookworm


LABEL org.opencontainers.image.authors="paul.depetrini@gmail.com"

RUN apt update -y
RUN apt install -y nginx 

RUN mkdir -p /etc/nginx/ssl
RUN apt install -y openssl
COPY conf/nginx.conf /nginx.conf
COPY conf/auto_config.sh /scripts/auto_config.sh
RUN chmod +x /scripts/auto_config.sh
ENTRYPOINT [ "/scripts/auto_config.sh" ]


