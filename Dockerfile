FROM linuxserver/baseimage
MAINTAINER lonix <lonixx@gmail.com>

ENV APTLIST="git python"

#Applying stuff
RUN apt-get update -q  && \
apt-get install $APTLIST -qy && \
apt-get clean && rm -rf /var/lib/apt/lists/* /var/tmp/*

#Adding Custom files
ADD init/ /etc/my_init.d/
ADD services/ /etc/service/
RUN chmod -v +x /etc/service/*/run /etc/my_init.d/*.sh

# Volumes and Ports
VOLUME /config /logs
EXPOSE 8181



