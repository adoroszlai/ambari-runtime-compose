#!/bin/bash

set -e -u

mkdir -p /etc/ambari-agent/conf

yum install -y curl git java-1.8.0-openjdk sudo wget
yum clean all
rm -rf /var/cache/yum

groupadd flokkr
echo "%flokkr ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/flokkr

curl -L -o /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64 && chmod +x /usr/local/bin/dumb-init
git clone -b envtoconf_ini https://github.com/adoroszlai/launcher.git
find -name onbuild.sh | xargs -n1 bash -c
