FROM centos
MAINTAINER carlos_chen  chenjianwei2@tuniu.com

RUN yum -y install python-setuptools 　
RUN easy_install supervisor
