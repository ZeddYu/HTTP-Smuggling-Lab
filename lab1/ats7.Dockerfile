FROM centos:7
ENV TERM xterm-256color
ENV container docker
WORKDIR /tmp
RUN yum clean all && yum update -y
RUN yum install vim wget telnet bind-utils net-tools lsof pkgconfig libtool gcc gcc-c++ make \
	openssl openssl-devel tcl tcl-devel pcre pcre-devel libcap libcap-devel \
	flex hwloc hwloc-devel lua ncurses ncurses-devel curl libcurl-devel autoconf automake \
libunwind libunwind-devel bzip2 expat-devel -y
RUN yum clean all && yum update -y
RUN wget http://archive.apache.org/dist/trafficserver/trafficserver-7.1.1.tar.bz2
RUN tar -xvf trafficserver-7.1.1.tar.bz2
WORKDIR /tmp/trafficserver-7.1.1
RUN autoreconf -if
RUN ./configure --prefix=/opt/ts \
  && make -j4 \
  && make check \
  && make install \
  && make distclean

WORKDIR /tmp
RUN rm -rf trafficserver-7.1.1*
RUN ln -s /opt/ts/etc/trafficserver /etc/trafficserver || /bin/true
RUN ln -s /opt/ts/bin/trafficserver /etc/init.d/trafficserver || /bin/true

# activate reverse proxy
RUN sed -i 's/CONFIG proxy.config.reverse_proxy.enabled INT 0/CONFIG proxy.config.reverse_proxy.enabled INT 1/g' /etc/trafficserver/records.config

RUN echo "map http://dummy-host7.example.com/ http://nginx/" > /etc/trafficserver/remap.config
RUN echo "reverse_map http://nginx/ http://dummy7-host.example.com/" >> /etc/trafficserver/remap.config

EXPOSE 8080

ENTRYPOINT ["/opt/ts/bin/traffic_cop"]
