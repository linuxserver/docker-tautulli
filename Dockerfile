FROM lsiobase/alpine.python:3.8

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="sparklyballs"

RUN \
 echo "**** install packages ****" && \
 apk add --no-cache --virtual=build-dependencies \
	g++ \
	gcc \
	make \
	python-dev && \
 echo "**** install pip packages ****" && \
 pip install --no-cache-dir -U \
	plexapi \
	pyopenssl \
	pycryptodomex && \
 echo "**** install app ****" && \
 git clone --depth 1 https://github.com/Tautulli/Tautulli /app/tautulli && \
 echo "**** cleanup ****" && \
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/root/.cache

# add local files
COPY root/ /

# ports and volumes
VOLUME /config /logs
EXPOSE 8181
