FROM flokkr/base:25

ARG MAVEN_VERSION=3.5.2

ENV CONF_DIR /etc/ambari-server/conf
ENV MAVEN_HOME /opt/maven
ENV PATH "$PATH:$MAVEN_HOME/bin"

RUN apk add --update --no-cache python
RUN ln -s /usr/bin/python /usr/bin/ambari-python-wrap

COPY download_apache.sh /
RUN /download_apache.sh "maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz" "$MAVEN_HOME"

RUN mkdir -p /var/lib/ambari-server/keys/db/newcerts && touch /var/lib/ambari-server/keys/db/index.txt
COPY ca.config /var/lib/ambari-server/keys/

# remove if launcher gets envtoconf_mkdir fix
WORKDIR /opt/launcher
COPY envtoconf.patch ./
RUN patch -p1 < envtoconf.patch

WORKDIR /opt/ambari/ambari-server

CMD [ "/bin/bash" ]
