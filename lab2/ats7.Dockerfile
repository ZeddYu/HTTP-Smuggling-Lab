FROM phusion/baseimage:master
RUN apt update
RUN apt-get install -y wget curl build-essential software-properties-common autoconf automake libtool bzip2 libffi-dev gcc g++ openssl libssl-dev tcl-dev libpcre3 libpcre3-dev libcap-dev lua5.3 libncurses5-dev make

# RUN yum clean all 
# RUN wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
# RUN yum update -y && yum makecache
WORKDIR /tmp
RUN wget http://archive.apache.org/dist/trafficserver/trafficserver-7.1.2.tar.bz2
RUN tar -xvf trafficserver-7.1.2.tar.bz2
WORKDIR /tmp/trafficserver-7.1.2
RUN autoreconf -if
RUN ./configure --prefix=/opt/ts \
  && make -j4 \
  && make check \
  && make install \
  && make distclean

WORKDIR /tmp
RUN rm -rf trafficserver-7.1.2*
RUN ln -s /opt/ts/etc/trafficserver /etc/trafficserver || /bin/true
RUN ln -s /opt/ts/bin/trafficserver /etc/init.d/trafficserver || /bin/true

# activate reverse proxy
RUN sed -i 's/CONFIG proxy.config.reverse_proxy.enabled INT 0/CONFIG proxy.config.reverse_proxy.enabled INT 1/g' /etc/trafficserver/records.config
RUN sed -i 's/CONFIG proxy.config.url_remap.remap_required INT 0/CONFIG proxy.config.url_remap.remap_required INT 1/g' /etc/trafficserver/records.config
RUN sed -i 's/CONFIG proxy.config.http.cache.http INT 1/CONFIG proxy.config.http.cache.http INT 0/g' /etc/trafficserver/records.config


RUN echo "map http://lnmp.com/ http://lnmp/" > /etc/trafficserver/remap.config
RUN echo "map http://lamp.com/ http://lamp/" >> /etc/trafficserver/remap.config

EXPOSE 8080

ENTRYPOINT ["/opt/ts/bin/traffic_cop"]
