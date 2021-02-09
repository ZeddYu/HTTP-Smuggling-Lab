FROM wyveo/nginx-php-fpm:php74

COPY lnmp/index.php /usr/share/nginx/html/index.php

EXPOSE 80
