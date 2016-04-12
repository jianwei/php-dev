FROM centos
MAINTAINER carlos_chen  chenjianwei2@tuniu.com

RUN yum -y install python-setuptools 　
RUN easy_install supervisor




RUN yum install -y wget make gcc-c++ glibc automake autoconf

#install memcached
RUN yum install -y libevent-devel



#install php
RUN yum -y  install libtool  libmcrypt-devel mhash-devel \
                    libxslt-devel  libjpeg libjpeg-devel \
                    libpng libpng-devel freetype freetype-devel \
                    libxml2 libxml2-devel zlib zlib-devel glibc \
                    glibc-devel glib2 glib2-devel bzip2 bzip2-devel \
                    ncurses ncurses-devel curl curl-devel e2fsprogs \
                    e2fsprogs-devel krb5 krb5-devel libidn libidn-devel \
                    openssl openssl-devel


RUN yum install pcre-devel openssl-devel zlib zlib-devel


#remove install packages
WORKDIR /usr/local/src/
RUN rm -fr *
WORKDIR /


