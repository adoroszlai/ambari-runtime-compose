#!/usr/bin/env bash

set -e -u

: ${ambariVersion:=2.0.0.0}
: ${buildNumber:=SNAPSHOT}
ambariFullVersion=${ambariVersion}-${buildNumber}
export ambariFullVersion ambariVersion buildNumber

version_file=$(fgrep server.version.file /etc/ambari-server/conf/ambari.properties | cut -f2 -d=)
: ${version_file:=/var/lib/ambari-server/resources/version}
echo "$ambariVersion" > $version_file

cp_file=/tmp/ambari-server.classpath

if [[ ! -f $cp_file ]] || [[ pom.xml -nt $cp_file ]]; then
  mvn -Dmaven.repo.local=/opt/maven_repo -Dmdep.outputFile=$cp_file dependency:build-classpath \
    && touch $cp_file # make sure it's newer even if "No changes found."
fi

java \
  -DskipDatabaseConsistencyValidation \
  -Xmx2048m -Xms256m -XX:+CMSClassUnloadingEnabled \
  -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005 \
  -classpath $(< $cp_file):target/classes:/etc/ambari-server/conf:conf/unix/log4j.properties \
  org.apache.ambari.server.controller.AmbariServer
