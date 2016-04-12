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

#*******************************************#
#install memcached                          #
#*******************************************#
RUN yum install -y libevent-devel
WORKDIR /usr/local/src
RUN wget http://www.memcached.org/files/memcached-1.4.25.tar.gz
RUN tar zxvf memcached-1.4.25.tar.gz
WORKDIR /usr/local/src/memcached-1.4.25
RUN ./configure --prefix=/usr/local/memcached
RUN make
RUN make install 


#*******************************************#
#install php                                #
#*******************************************#
RUN yum -y  install libtool  libmcrypt-devel mhash-devel \
                    libxslt-devel  libjpeg libjpeg-devel \
                    libpng libpng-devel freetype freetype-devel \
                    libxml2 libxml2-devel zlib zlib-devel glibc \
                    glibc-devel glib2 glib2-devel bzip2 bzip2-devel \
                    ncurses ncurses-devel curl curl-devel e2fsprogs \
                    e2fsprogs-devel krb5 krb5-devel libidn libidn-devel \
                    openssl openssl-devel
WORKDIR /usr/local/src/
RUN wget -c http://cn2.php.net/get/php-5.5.33.tar.gz/from/this/mirror -O php-5.5.33.tar.gz
RUN tar zxvf php-5.5.33.tar.gz
WORKDIR /usr/local/src/php-5.5.33
RUN ./configure --prefix=/usr/local/php  \
                --enable-fpm  \
                --enable-mbstring \
                --disable-pdo \
                --with-curl \
                --disable-debug  \
                --disable-rpath \
                --enable-inline-optimization \
                --with-bz2  \
                --with-zlib \
                --enable-sockets \
                --enable-sysvsem \
                --enable-sysvshm \
                --enable-pcntl \
                --enable-mbregex  \
                --enable-zip \
                --with-pcre-regex \
                --with-mysql \
                --with-mysqli \
                --with-gd \
                --with-jpeg-dir
RUN make
RUN make install
RUN cp php.ini-development  /usr/local/php/lib/php.ini

#*******************************************#
#install nginx                              #
#*******************************************#
RUN yum install pcre-devel openssl-devel zlib zlib-devel
WORKDIR /usr/local/src/
RUN wget http://nginx.org/download/nginx-1.9.9.tar.gz
RUN tar -zxvf nginx-1.9.9.tar.gz
WORKDIR /usr/local/src/nginx-1.9.9
RUN ./configure --prefix=/usr/local/nginx  \
                --with-http_ssl_module \
                --with-pcre\
                --with-http_stub_status_module
RUN make 
RUN make install


#*******************************************#
#install php extension                      #
#*******************************************#
WORKDIR /usr/local/src/
RUN wget http://pecl.php.net/get/memcache-2.2.7.tgz
RUN tar zxvf  memcache-2.2.7.tgz
WORKDIR /usr/local/src/memcache-2.2.7
RUN /usr/local/php/bin/phpize
RUN ./configure --with-php-config=/usr/local/php/bin/php-config
RUN make
RUN make install 

#*******************************************#
#load config                                #
#*******************************************#
RUN yum install unzip -y
WORKDIR /usr/local/src
RUN wget https://github.com/jianwei/php-dev/archive/master.zip
RUN unzip master.zip
RUN cp /usr/local/src/php-dev-master/conf/supervisord/supervisord.conf /etc/supervisord.conf
RUN cp /usr/local/src/php-dev-master/conf/php/php-fpm.conf  /usr/local/php/etc/
RUN cp /usr/local/src/php-dev-master/conf/php/php.ini  /usr/local/php/lib/
RUN cp /usr/local/src/php-dev-master/conf/nginx/nginx.conf  /usr/local/nginx/conf/




#remove install packages
WORKDIR /usr/local/src/
RUN rm -fr *
WORKDIR /

EXPOSE 22 80 443
#CMD supervisord  -c /etc/supervisord.conf
CMD ["/usr/bin/supervisord"]

#shell docker run -it -v /root/conf:/mnt/www:ro  --privileged=true   a2bc51f2efb6
