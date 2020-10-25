# HTTP-Smuggling-Lab

HTTP-Smuggling-Lab is a lab for learning about the http request smuggling.

## Installation

use docker-compose to build the lab in each directory.

## Usage

Read the README.md in details in each directory.

* In Lab1, we will chain some Reverse Proxy relations, Nginx will be the final backend, HaProxy the front load balancer, and between Nginx and HaProxy we will go through ATS6 or ATS7 based on the domain name used (dummy-host7.example.com for ATS7 and dummy-host6.example.com for ATS6).
* Lab2 uses ATS as front server and uses LAMP and LNMP as backend servers.
* Jetty is jetty v9.4.9. You will get more information in [Jetty-README](./jetty/README.md).
* Websocket Lab is about the websocket http smuggling. You will get more information in [Websocket-README](./websocket/lab1/README.md).
* HTTP/2 cleartext request smuggling please use this: [h2csmuggler](https://github.com/BishopFox/h2csmuggler)

You can learn more in [Help you understand HTTP Smuggling in one article](https://blog.zeddyu.info/2019/12/08/HTTP-Smuggling-en/) or the chinese version [一篇文章带你读懂 HTTP Smuggling 攻击](https://blog.zeddyu.info/2019/12/05/HTTP-Smuggling/).

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

Thanks to @regilero and mengchen@Knownsec 404 Team.

## License
[MIT](https://choosealicense.com/licenses/mit/)