#!/bin/sh

set -e

output_proxy_setting() {
    if [ x${1} != x"" -a x${2} != x"" -a x${3} != x"" ]; then
        cat <<EOF >> ${JENKINS_HOME}/.m2/settings.xml
   <proxy>
      <id>${1}</id>
      <active>true</active>
      <protocol>${1}</protocol>
      <host>${2}</host>
      <port>${3}</port>
EOF
        if [ x${no_proxy} != x"" ]; then
            non_proxy_hosts=`echo ${no_proxy} | sed 's/,/|/'`
            cat <<EOF >> ${JENKINS_HOME}/.m2/settings.xml
      <nonProxyHosts>${non_proxy_hosts}</nonProxyHosts>
EOF
        fi
        cat <<EOF >> ${JENKINS_HOME}/.m2/settings.xml
    </proxy>
EOF
    fi
}

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
        output_proxy_setting http ${proxy_host} ${proxy_port}
    fi
    if [ x${https_proxy} != x"" ]; then
        proxy_host=`echo ${https_proxy}|sed 's#http://##' | sed 's/:.*//'`
        proxy_port=`echo ${https_proxy}|sed 's#.*:##'`
        output_proxy_setting http ${proxy_host} ${proxy_port}
    fi
    cat <<EOF >> ${JENKINS_HOME}/.m2/settings.xml
  </proxies>
</settings>
EOF
fi

exec /usr/local/bin/jenkins.sh
