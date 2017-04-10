FROM lsiobase/alpine.python:3.5
MAINTAINER sparklyballs

# add local files
COPY root/ /

# install packages
RUN \
 apk add --no-cache \
	openssl

# ports and volumes
VOLUME /config /logs
EXPOSE 8181
