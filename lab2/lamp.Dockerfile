FROM php:7.4-apache-buster

COPY ./lamp/index.php /var/www/html/index.php

EXPOSE 80