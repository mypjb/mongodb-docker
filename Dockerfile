FROM centos

MAINTAINER mypjb/mongodb docker maintainer 280417314@qq.com

#mongodb dowload url
ENV MONGO_URL https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-rhel70-3.4.4.tgz

#mongodb install path
ENV MONGO_PATH /usr/local/mongodb

#mongodb git 
ENV MONGO_GIT https://github.com/mypjb/mongodb-docker.git

RUN yum -y update \
	&& yum install -y gcc make net-tools wget git

RUN wget $MONGO_URL -O mongodb.tar.gz \
	&& mkdir -p $MONGO_PATH \
	&& tar xzf mongodb.tar.gz -C $MONGO_PATH --strip-components=1 \
	&& rm -rf mongodb.tar.gz \
	&& cd $MONGO_PATH \
	&& git clone $MONGO_GIT  mongodb_git \
	&& mkdir conf \
	&& cp mongodb_git/conf/* conf \
	&& mkdir -p /storage/mongodb/db \
	&& mkdir -p /storage/mongodb/log \
	&& ln -s $MONGO_PATH/bin/mongod /usr/local/bin

EXPOSE 27017 28017
	
CMD mongod -f $MONGO_PATH/conf/mongodb.conf ; /bin/bash ;
