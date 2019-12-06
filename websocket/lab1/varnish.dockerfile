FROM varnish
MAINTAINER Zedd="zeddyu.lu@gmail.com"

COPY conf/default.vcl /etc/varnish/default.vcl

EXPOSE 80