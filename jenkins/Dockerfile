FROM jenkins:alpine

LABEL maintainer "Hidetoshi Imai <hidepin@gmail.com>"

COPY files/plugins.txt /usr/share/jenkins/ref/plugins.txt
COPY files/docker-entrypoint.sh /docker-entrypoint.sh

RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]
