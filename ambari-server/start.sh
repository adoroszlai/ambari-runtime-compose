#!/usr/bin/env bash

set -e -u

: ${ambariVersion:=2.0.0.0}
: ${buildNumber:=SNAPSHOT}
ambariFullVersion=${ambariVersion}-${buildNumber}
export ambariFullVersion ambariVersion buildNumber

version_file=$(fgrep server.version.file /etc/ambari-server/conf/ambari.properties | cut -f2 -d=)
: ${version_file:=/var/lib/ambari-server/version}
echo "$ambariVersion" > $version_file

cp_file=/tmp/ambari-server.classpath

if [[ ! -f $cp_file ]] || [[ pom.xml -nt $cp_file ]]; then
  mvn -Dmaven.repo.local=/opt/maven_repo -Dmdep.outputFile=$cp_file dependency:build-classpath \
    && touch $cp_file # make sure it's newer even if "No changes found."
fi

views_dir=$(fgrep views.dir /etc/ambari-server/conf/ambari.properties | cut -f2 -d=)
: ${views_dir:=/var/lib/ambari-server/views}
if [[ ! -d ${views_dir} ]]; then
  mkdir -p ${views_dir}
  cp /opt/ambari/ambari-admin/target/ambari-admin*jar ${views_dir}/
fi

tmp_dir=$(fgrep server.tmp.dir /etc/ambari-server/conf/ambari.properties | cut -f2 -d=)
: ${tmp_dir:=/var/lib/ambari-server/data/tmp}
mkdir -p "$tmp_dir"

CLASSPATH=$(< $cp_file):target/classes:/etc/ambari-server/conf
jdbc_driver=$(fgrep server.jdbc.driver.path /etc/ambari-server/conf/ambari.properties | cut -f2 -d=)
[[ -n $jdbc_driver ]] && [[ -e $jdbc_driver ]] && CLASSPATH=$CLASSPATH:$jdbc_driver
export CLASSPATH

java \
  -DskipDatabaseConsistencyValidation \
  -Djava.io.tmpdir="$tmp_dir" \
  -Xmx2048m -Xms256m -XX:+CMSClassUnloadingEnabled \
  -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005 \
  org.apache.ambari.server.controller.AmbariServer
