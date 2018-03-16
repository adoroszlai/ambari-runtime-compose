#!/usr/bin/env bash

set -e -u

dependencies=$(mvn -pl ambari-server -Dmaven.repo.local=/opt/maven_repo dependency:list | fgrep '[INFO]    org.apache.ambari' | cut -f2 -d: | xargs -r -n1 find * -maxdepth 2 -type d -name)
mvn -pl $(echo ${dependencies} | sed 's/ /,/g') -Dmaven.repo.local=/opt/maven_repo -Dcheckstyle.skip -Dfindbugs.skip -Dmaven.test.skip -Drat.skip install
mvn -pl ambari-server -Dmaven.repo.local=/opt/maven_repo -Dmdep.outputFile=target/classes/.classpath dependency:build-classpath
