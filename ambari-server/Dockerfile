FROM flokkr/base:25

ENV MAVEN_HOME /opt/maven
RUN mkdir -p $MAVEN_HOME \
  && curl -L -s -S https://archive.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz \
    | tar -xzf - --strip-components 1 -C $MAVEN_HOME
ENV PATH "$PATH:$MAVEN_HOME/bin"

RUN mkdir -p /etc/ambari-server/conf
ADD start.sh /

CMD [ "/start.sh" ]
