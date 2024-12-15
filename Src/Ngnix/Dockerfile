FROM debian:oldstable-slim

RUN apt-get update && apt-get install -y nginx openssl

EXPOSE 443

COPY conf/default /etc/nginx/sites-enabled/default

COPY html/ /var/www/html/

COPY ./tools/nginx.sh /var/

RUN chmod +x /var/nginx.sh

ENTRYPOINT [ "/var/nginx.sh" ]

CMD ["nginx", "-g", "daemon off;"]
