#!/usr/bin/env bash

set -e -u

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
