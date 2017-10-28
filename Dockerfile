FROM lsiobase/alpine.python:3.6
MAINTAINER sparklyballs

# set version label
ARG BUILD_DATE
ARG VERSION
ARG GIT_BRANCH=master
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

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

# install app
 git clone --branch $GIT_BRANCH --depth 1 https://github.com/JonnyWong16/plexpy /app/plexpy && \

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
