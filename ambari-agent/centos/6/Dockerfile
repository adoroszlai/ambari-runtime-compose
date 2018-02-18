FROM centos:6

ENV CONF_DIR /etc/ambari-agent/conf
WORKDIR /opt

COPY build.sh /
RUN /build.sh
RUN cd /opt/launcher && git checkout -- .

ENV PYTHON=/usr/bin/python
RUN ln -s $PYTHON /usr/bin/ambari-python-wrap

ENTRYPOINT ["/usr/local/bin/dumb-init", "--", "/opt/launcher/launcher.sh"]
CMD [ "/bin/bash" ]
