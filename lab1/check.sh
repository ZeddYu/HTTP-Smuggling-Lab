printf 'GET / HTTP/1.1\r\n'\
'Host:dummy-host7.example.com\r\n'\
'Connection: close\r\n'\
'\r\n'\
| nc 127.0.0.1 8002

printf 'GET / HTTP/1.1\r\n'\
'Host:dummy-host7.example.com\r\n'\
'Connection: close\r\n'\
'\r\n'\
| nc 127.0.0.1 8007

printf 'GET / HTTP/1.1\r\n'\
'Host:dummy-host6.example.com\r\n'\
'Connection: close\r\n'\
'\r\n'\
| nc 127.0.0.1 8006

printf 'GET / HTTP/1.1\r\n'\
'Host:dummy-host7.example.com\r\n'\
'Connection: close\r\n'\
'\r\n'\
| nc 127.0.0.1 8001

printf 'GET / HTTP/1.1\r\n'\
'Host:dummy-host6.example.com\r\n'\
'Connection: close\r\n'\
'\r\n'\
| nc 127.0.0.1 8001

printf 'GET /?cache=1 HTTP/1.1\r\n'\
'Host:dummy-host7.example.com\r\n'\
'\r\n'\
'GET /?cache=2 HTTP/1.1\r\n'\
'Host:dummy-host7.example.com\r\n'\
'\r\n'\
'GET /?cache=3 HTTP/1.1\r\n'\
'Host:dummy-host6.example.com\r\n'\
'\r\n'\
'GET /?cache=4 HTTP/1.1\r\n'\
'Host:dummy-host6.example.com\r\n'\
'\r\n'\
| nc 127.0.0.1 8001