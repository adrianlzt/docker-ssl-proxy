FROM alpine

RUN apk update && apk add nginx openssl gettext

ADD dhparam.pem /etc/nginx/dhparam.pem
ADD add_self_signed_certs.sh /
ADD nginx.conf.template /
ADD configure_nginx.sh /

EXPOSE 443

ENTRYPOINT ["/configure_nginx.sh"]
