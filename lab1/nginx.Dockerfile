FROM nginx:latest

RUN /bin/sh -c 'rm /etc/nginx/conf.d/default.conf || /bin/true'

RUN echo '<html><head><title>Nginx default static page</title></head>\n\
<body><h1>Hello World</h1>\n\
<p>It works!</p>\n\
</body></html>' > /usr/share/nginx/html/index.html

RUN echo 'server {\n\
    listen       80;\n\
    server_name  dummy-host.example.com;\n\
\n\
    location / {\n\
        root   /usr/share/nginx/html;\n\
        index  index.html index.htm;\n\
        add_header X-Location-echo $request_uri;\n\
        add_header X-Default-VH 0;\n\
        add_header Cache-Control "public, max-age=300";\n\
    }\n\
\n\
    # redirect server error pages to the static page /50x.html\n\
    #\n\
    error_page   500 502 503 504  /50x.html;\n\
    location = /50x.html {\n\
        root   /usr/share/nginx/html;\n\
    }\n\
}\n'> /etc/nginx/conf.d/vhost.conf
