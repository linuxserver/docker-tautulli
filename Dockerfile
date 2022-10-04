FROM ghcr.io/linuxserver/baseimage-alpine:3.16

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="nemchik,thelamer"

# Inform app this is a docker env
ENV TAUTULLI_DOCKER=True

RUN \
  echo "**** install build packages ****" && \
  apk add --no-cache --virtual=build-dependencies \
    g++ \
    gcc \
    make \
    python3-dev && \
  echo "**** install packages ****" && \
  apk add --no-cache \
    curl \
    git \
    py3-openssl \
    py3-pip \
    py3-setuptools \
    python3 && \
  echo "**** install pip packages ****" && \
  python3 -m pip install --upgrade pip wheel && \
  pip install -U --no-cache-dir --find-links https://wheel-index.linuxserver.io/alpine-3.16/ \
    mock \
    plexapi \
    pycryptodomex && \
  echo "**** install app ****" && \
  mkdir -p /app/tautulli && \
  git clone https://github.com/Tautulli/Tautulli.git /app/tautulli && \
  cd /app/tautulli && \
  git checkout nightly && \
  echo "**** Hard Coding versioning ****" && \
  echo "${VERSION}" > /app/tautulli/version.txt && \
  echo "nightly" > /app/tautulli/branch.txt && \
  echo "**** cleanup ****" && \
  apk del --purge \
    build-dependencies && \
  rm -rf \
    /root/.cache \
    /tmp/*

# add local files
COPY root/ /

# ports and volumes
VOLUME /config
EXPOSE 8181
