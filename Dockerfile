FROM lsiobase/alpine.python
MAINTAINER sparklyballs

# add local files
COPY root/ /

# ports and volumes
VOLUME /config /logs
EXPOSE 8181
