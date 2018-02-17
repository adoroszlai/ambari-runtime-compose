#!/bin/bash

set -e -u

mkdir -p $MAVEN_HOME
maven_url=$(curl -LSs http://www.apache.org/dyn/closer.cgi/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz?as_json=1 \
 | jq --raw-output '.preferred,.path_info' \
 | sed -e '1N' -e 's/\n//')
: ${maven_url:="http://www.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz"}
echo "Downloading Maven from ${maven_url}"
curl -LSs "${maven_url}" | tar -xzf - --strip-components 1 -C $MAVEN_HOME

mkdir -p /etc/ambari-server/conf
