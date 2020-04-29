FROM mattrayner/lamp:latest-1804

COPY ./lamp/index.php /app/index.php

CMD ["/run.sh"]