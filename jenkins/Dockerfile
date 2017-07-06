FROM jenkins:alpine

LABEL maintainer "Hidetoshi Imai <hidepin@gmail.com>"

COPY files/plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
RUN echo 2.60.1 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state
