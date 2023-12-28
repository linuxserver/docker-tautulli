# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-alpine:3.19

# set version label
ARG BUILD_DATE
ARG VERSION
ARG TAUTULLI_COMMIT
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
  if [ -z ${TAUTULLI_COMMIT+x} ]; then \
    TAUTULLI_COMMIT=$(curl -s https://api.github.com/repos/Tautulli/Tautulli/commits/nightly \
      | jq -r '. | .sha' \
      | cut -c1-8); \
  fi && \
  mkdir -p /app/tautulli && \
  curl -o \
    /tmp/tautulli.tar.gz -L \
    "https://github.com/Tautulli/Tautulli/archive/${TAUTULLI_COMMIT}.tar.gz" && \
  tar xf \
    /tmp/tautulli.tar.gz -C \
    /app/tautulli --strip-components=1 && \
  cd /app/tautulli && \
  sed -i 's/^backports.zoneinfo==0.2.1$/backports.zoneinfo==0.2.1;python_version<"3.9"/' requirements.txt && \
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
  echo "${TAUTULLI_COMMIT}" > /app/tautulli/version.txt && \
  echo "nightly" > /app/tautulli/branch.txt && \
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
