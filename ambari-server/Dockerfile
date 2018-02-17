FROM flokkr/base:25

ARG MAVEN_VERSION=3.5.2

ENV MAVEN_HOME /opt/maven
ENV PATH "$PATH:$MAVEN_HOME/bin"

COPY build.sh /
RUN /build.sh
ADD start.sh /

CMD [ "/start.sh" ]
