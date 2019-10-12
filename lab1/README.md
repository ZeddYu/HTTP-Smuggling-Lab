#	LAB1

##	Composition

1.HaProxy 1.6

2.Apache Traffic Server 6.2.2

3.Apache Traffic Server 7.1.1

4.nginx:latest

```
                                   +---[80]---+
                                   | 8001->80 |
                                   |  HaProxy |
                                   |          |
                                   +--+---+---+
            [dummy-host6.example.com] |   | [dummy-host7.example.com]
                              +-------+   +------+
                              |                  |
                          +-[8080]-----+     +-[8080]-----+
                          | 8006->8080 |     | 8007->8080 |
                          |  ATS6      |     |  ATS7      |
                          |            |     |            |
                          +-----+------+     +----+-------+
                                |               |
                                +-------+-------+
                                        |
                                   +--[80]----+
                                   | 8002->80 |
                                   |  Nginx   |
                                   |          |
                                   +----------+
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
HTTP/1.1 200 OK
HTTP/1.1 200 OK
HTTP/1.1 200 OK
HTTP/1.1 200 OK
HTTP/1.1 200 OK
HTTP/1.1 200 OK
HTTP/1.1 200 OK
```

9 HTTP code 200 means all right! 

Enjoy!



#	Reference

https://regilero.github.io/english/security/2019/10/17/security_apache_traffic_server_http_smuggling/#toc5