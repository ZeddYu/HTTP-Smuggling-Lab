FROM httpd:latest
MAINTAINER Zedd

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

COPY src/websocket.html /usr/local/apache2/htdocs/

WORKDIR /usr/local/apache2/htdocs
EXPOSE 80