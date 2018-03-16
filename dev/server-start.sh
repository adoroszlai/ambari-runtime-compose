#!/usr/bin/env bash
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e -u

CLASSPATH=/usr/lib/ambari-server/classes:/etc/ambari-server/conf:$(</usr/lib/ambari-server/classes/.classpath)
jdbc_driver=$(fgrep server.jdbc.driver.path /etc/ambari-server/conf/ambari.properties | cut -f2 -d=)
[[ -n ${jdbc_driver} ]] && [[ -s ${jdbc_driver} ]] && CLASSPATH=${CLASSPATH}:${jdbc_driver}
export CLASSPATH

java \
  -DskipDatabaseConsistencyValidation \
  -Xmx2048m -Xms256m -XX:+CMSClassUnloadingEnabled \
  -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005 \
  org.apache.ambari.server.controller.AmbariServer
