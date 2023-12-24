# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-alpine:3.19

# set version label
ARG BUILD_DATE
ARG VERSION
ARG TAUTULLI_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="nemchik,thelamer"

# Inform app this is a docker env
ENV TAUTULLI_DOCKER=True

RUN \
  echo "**** install build packages ****" && \
  apk add --no-cache --virtual=build-dependencies \
    build-base \
    cargo \
    python3-dev && \
  echo "**** install packages ****" && \
  apk add --no-cache \
    git \
    python3 && \
  echo "**** install tautulli ****" && \
  if [ -z ${TAUTULLI_RELEASE+x} ]; then \
    TAUTULLI_RELEASE=$(curl -sX GET "https://api.github.com/repos/Tautulli/Tautulli/releases/latest" \
    | jq -r '. | .tag_name'); \
  fi && \
  mkdir -p /app/tautulli && \
  curl -o \
    /tmp/tautulli.tar.gz -L \
    "https://github.com/Tautulli/Tautulli/archive/${TAUTULLI_RELEASE}.tar.gz" && \
  tar xf \
    /tmp/tautulli.tar.gz -C \
    /app/tautulli --strip-components=1 && \
  cd /app/tautulli && \
  python3 -m venv /lsiopy && \
  pip install -U --no-cache-dir \
    pip \
    wheel && \
  pip install -U --no-cache-dir --find-links https://wheel-index.linuxserver.io/alpine-3.19/ \
    cryptography \
    pycryptodomex \
    pyopenssl && \
  pip install -U --no-cache-dir --find-links https://wheel-index.linuxserver.io/alpine-3.19/ \
    -r requirements.txt && \
  echo "**** Hard Coding versioning ****" && \
  echo "${TAUTULLI_RELEASE}" > /app/tautulli/version.txt && \
  echo "master" > /app/tautulli/branch.txt && \
  echo "**** cleanup ****" && \
  apk del --purge \
    build-dependencies && \
  rm -rf \
    /tmp/* \
    $HOME/.cache \
    $HOME/.cargo

# add local files
COPY root/ /

# ports and volumes
EXPOSE 8181
VOLUME /config
