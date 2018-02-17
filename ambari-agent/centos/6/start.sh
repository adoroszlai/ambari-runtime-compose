#!/usr/bin/env bash

set -e -u

: ${ambariVersion:=2.0.0.0}
: ${buildNumber:=SNAPSHOT}

export ambariVersion buildNumber

mkdir -p /var/lib/ambari-agent/{cache,cred,data,keys} /var/log/ambari-agent /var/run/ambari-agent
echo ${ambariVersion} > /var/lib/ambari-agent/data/version

export PATH=$PATH:/usr/lib/ambari-agent/bin

ambari-agent start
while true; do
  sleep 3
  tail -f /var/log/ambari-agent/ambari-agent.log
done
