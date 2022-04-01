FROM haproxy:1.9.10
EXPOSE 80

RUN echo 'defaults\n\
    mode http\n\
    timeout http-keep-alive 10s\n\
    timeout connect 5s\n\
    timeout server 60s\n\
    timeout client 30s\n\
    timeout http-request 30s\n\
\n\
backend web\n\
    http-reuse always\n\
    server web0 gunicorn:6767\n\
\n\
frontend http\n\
    bind *:80\n\
    timeout client 5s\n\
    timeout http-request 10s\n\
    default_backend web\n\
\n\
\n'> /usr/local/etc/haproxy/haproxy.cfg

CMD ["haproxy", "-f", "/usr/local/etc/haproxy/haproxy.cfg"]
