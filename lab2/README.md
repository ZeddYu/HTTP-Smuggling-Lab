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



#	Reference

https://paper.seebug.org/1049/#42-test-environment