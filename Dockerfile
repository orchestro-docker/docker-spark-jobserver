FROM centos:7
MAINTAINER  Jared Holmberg <jared.holmberg@orchestro.com>

RUN yum install -y git

RUN curl https://bintray.com/sbt/rpm/rpm | tee /etc/yum.repos.d/bintray-sbt-rpm.repo
RUN yum install -y sbt


RUN mkdir /spark
WORKDIR /spark

RUN git clone https://github.com/spark-jobserver/spark-jobserver.git

WORKDIR /spark/spark-jobserver/

RUN export VER=`sbt version | tail -1 | cut -f2`

# Pre-fetch dependencies and kill
RUN sbt reStart

EXPOSE 8090

ADD /spark/spark-jobserver/bin/server_start.sh ./

RUN pwd

RUN ls -la

CMD /spark/spark-jobserver/bin/server_start.sh
