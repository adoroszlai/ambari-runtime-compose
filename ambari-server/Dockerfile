FROM flokkr/base:25

ARG MAVEN_VERSION=3.5.2

ENV CONF_DIR /etc/ambari-server/conf
ENV MAVEN_HOME /opt/maven
ENV PATH "$PATH:$MAVEN_HOME/bin"

COPY build.sh /
RUN /build.sh

RUN mkdir -p /var/lib/ambari-server/keys/db/newcerts && touch /var/lib/ambari-server/keys/db/index.txt
COPY ca.config /var/lib/ambari-server/keys/

COPY start.sh /

# remove if launcher gets envtoconf_mkdir fix
WORKDIR /opt/launcher
COPY envtoconf.patch ./
RUN patch -p1 < envtoconf.patch

WORKDIR /opt/ambari/ambari-server

CMD [ "/start.sh" ]
