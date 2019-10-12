printf 'GET / HTTP/1.1\r\n'\
'Host: lnmp.com\r\n'\
'Connection: close\r\n'\
'\r\n'\
| nc 127.0.0.1 9012

printf 'GET / HTTP/1.1\r\n'\
'Host: lamp.com\r\n'\
'Connection: close\r\n'\
'\r\n'\
| nc 127.0.0.1 9011

printf 'GET / HTTP/1.1\r\n'\
'Host: lnmp.com\r\n'\
'Connection: close\r\n'\
'\r\n'\
| nc 127.0.0.1 9010

printf 'GET / HTTP/1.1\r\n'\
'Host: lamp.com\r\n'\
'Connection: close\r\n'\
'\r\n'\
| nc 127.0.0.1 9010