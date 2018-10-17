FROM ubuntu:16.04
LABEL maintainer vivekv@vivekv.com
RUN apt-get update; apt-get -y install curl python cron
RUN curl -O https://bootstrap.pypa.io/get-pip.py && python get-pip.py && rm -f get-pip.py &&  pip install awscli && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
COPY cron.sh /
COPY bootstrap.sh /
RUN echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list && \
    apt-get update &&  apt-get install  mongodb-org-tools && chmod +x /cron.sh
CMD /bin/sh /bootstrap.sh
