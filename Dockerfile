FROM centos
MAINTAINER carlos_chen  chenjianwei2@tuniu.com

RUN yum -y install python-setuptools 　
RUN easy_install supervisor


#Install apache
RUN yum install -y wget apr-util-devel  apr-devel gcc  pcre-devel openssl-devel  make perl 
WORKDIR /usr/local/src/
RUN wget http://mirrors.hust.edu.cn/apache//httpd/httpd-2.4.18.tar.gz
RUN tar zxvf httpd-2.4.18.tar.gz
WORKDIR /usr/local/src/httpd-2.4.18
RUN ./configure --prefix=/usr/local/apache2 --enable-so --enable-cgi --enable-proxy --enable-vhost-alias --enable-cache --enable-disk-cache --enable-mem-cache --enable-rewrite --enable-mods-shared=all --enable-usertrack --enable-ssl
RUN make 
RUN make install

#install memcached
RUN　yum install -y libevent-devel
WORKDIR /usr/local/src
RUN wget http://www.memcached.org/files/memcached-1.4.25.tar.gz
RUN tar zxvf memcached-1.4.25.tar.gz
WORKDIR /usr/local/src/memcached-1.4.25
RUN ./configure --prefix=/usr/local/memcached
RUN make
RUN make install 
