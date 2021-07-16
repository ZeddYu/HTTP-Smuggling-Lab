FROM haproxy:1.6
EXPOSE 80

RUN echo 'defaults\n\
    mode http\n\
    option http-keep-alive\n\
    timeout connect 5000\n\
    timeout client 10000\n\
    timeout server 10000\n\
\n\
frontend http-in\n\
    bind *:80\n\
    mode http\n\
    default_backend ats7_vhost\n\
    # define (virtual)hosts\n\
    acl vhost6 hdr(host) -i dummy-host6.example.com\n\
    acl vhost7 hdr(host) -i dummy-host7.example.com\n\
    use_backend ats6_vhost if vhost6\n\
    use_backend ats7_vhost if vhost7\n\
\n\
backend ats7_vhost\n\
    mode http\n\
    option forwardfor\n\
    server ats7 ats7:8080\n\
\n\
backend ats6_vhost\n\
    mode http\n\
    option forwardfor\n\
    server ats6 ats6:8080\n\
\n'> /usr/local/etc/haproxy/haproxy.cfg

CMD ["haproxy", "-f", "/usr/local/etc/haproxy/haproxy.cfg"]
