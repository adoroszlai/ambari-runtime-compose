#!/usr/bin/env bash

set -e -u

: ${ambariVersion:=2.0.0.0}
: ${buildNumber:=SNAPSHOT}

export ambariVersion buildNumber

mkdir -p /var/lib/ambari-agent/{cache,cred,data,keys,tmp} /var/log/ambari-agent /var/run/ambari-agent
echo ${ambariVersion} > /var/lib/ambari-agent/data/version
[[ -n ${AMBARI_SERVER_RESOURCES} ]] && [[ -e ${AMBARI_SERVER_RESOURCES} ]] && cp -r ${AMBARI_SERVER_RESOURCES}/{common-services,stacks,mpacks} /var/lib/ambari-agent/cache/

export PATH=$PATH:/usr/lib/ambari-agent/bin

ambari-agent start
while true; do
  sleep 3
  tail -f /var/log/ambari-agent/ambari-agent.log
done
