FROM lsiobase/alpine.python:3.5
MAINTAINER sparklyballs

# install packages
RUN \
 apk add --no-cache --virtual=build-dependencies \
     g++ \
     gcc \
     make \
     python-dev && \

# install pycryptodomex
 pip install \
     pycryptodomex && \
 
# cleanup
 apk del --purge \
     build-dependencies

# add local files
COPY root/ /

# ports and volumes
VOLUME /config /logs
EXPOSE 8181
