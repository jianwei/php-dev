FROM centos
MAINTAINER carlos_chen  chenjianwei2@tuniu.com

RUN yum -y install python-setuptools 　
RUN easy_install supervisor


#Install apache
#RUN yum install -y wget apr-util-devel  apr-devel gcc  pcre-devel openssl-devel  make perl 
#WORKDIR /usr/local/src/
#RUN wget http://mirrors.hust.edu.cn/apache//httpd/httpd-2.4.18.tar.gz
#RUN tar zxvf httpd-2.4.18.tar.gz
#WORKDIR /usr/local/src/httpd-2.4.18
#RUN ./configure --prefix=/usr/local/apache2 --enable-so --enable-cgi --enable-proxy --enable-vhost-alias --enable-cache --enable-disk-cache --enable-mem-cache --enable-rewrite --enable-mods-shared=all --enable-usertrack --enable-ssl
#RUN make 
#RUN make install

RUN yum install -y wget make gcc-c++ glibc automake autoconf

#install memcached
RUN yum install -y libevent-devel
WORKDIR /usr/local/src
RUN wget http://www.memcached.org/files/memcached-1.4.25.tar.gz
RUN tar zxvf memcached-1.4.25.tar.gz
WORKDIR /usr/local/src/memcached-1.4.25
RUN ./configure --prefix=/usr/local/memcached
RUN make
RUN make install 


#install php
RUN yum -y install   libtool  libmcrypt-devel mhash-devel libxslt-devel  libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel libxml2 libxml2-devel zlib zlib-devel glibc glibc-devel glib2 glib2-devel bzip2 bzip2-devel ncurses ncurses-devel curl curl-devel e2fsprogs e2fsprogs-devel krb5 krb5-devel libidn libidn-devel openssl openssl-devel
WORKDIR /usr/local/src/
RUN wget -c http://cn2.php.net/get/php-5.5.33.tar.gz/from/this/mirror -O php-5.5.33.tar.gz
RUN tar zxvf php-5.5.33.tar.gz

#install libmcrypt-2.5.7.tar.gz 
#WORKDIR /usr/local/src/
#RUN wget ftp://mcrypt.hellug.gr/pub/crypto/mcrypt/attic/libmcrypt/libmcrypt-2.5.7.tar.gz 
#RUN tar -zxvf libmcrypt-2.5.7.tar.gz   
#WORKDIR /usr/local/src/libmcrypt-2.5.7  
#RUN ./configure --prefix=/usr/local/libmcrypt  
#RUN make && make install

# build php
WORKDIR /usr/local/src/php-5.5.33
RUN ./configure --prefix=/usr/local/php  --enable-fpm  --enable-mbstring --disable-pdo --with-curl --disable-debug  --disable-rpath --enable-inline-optimization --with-bz2  --with-zlib --enable-sockets --enable-sysvsem --enable-sysvshm --enable-pcntl --enable-mbregex  --enable-zip --with-pcre-regex --with-mysql --with-mysqli --with-gd --with-jpeg-dir
RUN make
RUN make install
RUN cp php.ini-development  /usr/local/php/lib/php.ini

