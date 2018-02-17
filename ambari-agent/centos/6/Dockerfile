FROM centos:6

ENV PERMISSION_FIX=true
VOLUME /data
WORKDIR /opt

COPY build.sh /
RUN /build.sh
COPY start.sh /
RUN cd /opt/launcher && git checkout -- .

ENV PYTHON=/usr/bin/python

ENTRYPOINT ["/usr/local/bin/dumb-init", "--", "/opt/launcher/launcher.sh"]

CMD [ "/start.sh" ]
