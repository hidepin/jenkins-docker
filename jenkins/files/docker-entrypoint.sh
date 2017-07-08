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

exec /usr/local/bin/jenkins.sh
