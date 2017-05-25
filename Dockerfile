FROM lsiobase/alpine.python:3.6
MAINTAINER sparklyballs

# install packages
RUN \
 apk add --no-cache --virtual=build-dependencies \
	g++ \
	gcc \
	make \
	python-dev && \

# install pycryptodomex
 pip install --no-cache-dir -U \
	pycryptodomex && \

# cleanup
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/root/.cache

# add local files
COPY root/ /

# ports and volumes
VOLUME /config /logs
EXPOSE 8181
