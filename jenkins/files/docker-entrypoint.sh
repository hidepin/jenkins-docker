#!/bin/sh

set -e

if [ ! -f "${JENKINS_HOME}/.ssh/id_rsa.pub" ]; then
    echo "generate ssh key file."
    mkdir -p ${JENKINS_HOME}/.ssh
    ssh-keygen -N '' -f ${JENKINS_HOME}/.ssh/id_rsa
fi

echo "*************************************************************"
echo ${JENKINS_HOME}/.ssh/id_rsa.pub
cat ${JENKINS_HOME}/.ssh/id_rsa.pub
echo "*************************************************************"

if [ ! -f ${JENKINS_HOME}/.m2/settings.xml -a \( x${http_proxy} != x"" -o x${https_proxy} != x"" \) ]; then
    echo "generate proxy setting file."
    mkdir -p ${JENKINS_HOME}/.m2
    cat <<EOF > ${JENKINS_HOME}/.m2/settings.xml
<?xml version="1.0" encoding="UTF-8"?>
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">
  <proxies>
EOF
    if [ x${http_proxy} != x"" ]; then
        proxy_host=`echo ${http_proxy}|sed 's#http://##' | sed 's/:.*//'`
        proxy_port=`echo ${http_proxy}|sed 's#.*:##'`
        cat <<EOF >> ${JENKINS_HOME}/.m2/settings.xml
   <proxy>
      <id>http</id>
      <active>true</active>
      <protocol>http</protocol>
      <host>${proxy_host}</host>
      <port>${proxy_port}</port>
    </proxy>
EOF
    fi
    if [ x${https_proxy} != x"" ]; then
        proxy_host=`echo ${https_proxy}|sed 's#http://##' | sed 's/:.*//'`
        proxy_port=`echo ${https_proxy}|sed 's#.*:##'`
        cat <<EOF >> ${JENKINS_HOME}/.m2/settings.xml
   <proxy>
      <id>https</id>
      <active>true</active>
      <protocol>https</protocol>
      <host>${proxy_host}</host>
      <port>${proxy_port}</port>
    </proxy>
EOF
    fi
    cat <<EOF >> ${JENKINS_HOME}/.m2/settings.xml
  </proxies>
</settings>
EOF
fi

exec /usr/local/bin/jenkins.sh
