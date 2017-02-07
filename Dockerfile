FROM lsiobase/alpine.python:3.5
MAINTAINER sparklyballs

# add local files
COPY root/ /

# ports and volumes
VOLUME /config /logs
EXPOSE 8181
