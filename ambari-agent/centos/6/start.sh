#!/usr/bin/env bash

set -e -u

: ${ambariVersion:=2.0.0.0}
: ${buildNumber:=SNAPSHOT}

export ambariVersion buildNumber

mkdir -p /var/lib/ambari-agent/{cache,cred,data,keys} /var/log/ambari-agent /var/run/ambari-agent
export PATH=$PATH:/usr/lib/ambari-agent/bin
#python /opt/ambari/ambari-agent/src/main/python/ambari_agent/main.py
ambari-agent start
while true; do
  sleep 3
  tail -f /var/log/ambari-agent/ambari-agent.log
done
