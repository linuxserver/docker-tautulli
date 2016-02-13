FROM linuxserver/baseimage.python
MAINTAINER lonix <lonixx@gmail.com>

#Adding Custom files
ADD init/ /etc/my_init.d/
ADD services/ /etc/service/
RUN chmod -v +x /etc/service/*/run /etc/my_init.d/*.sh

# Volumes and Ports
VOLUME /config /logs
EXPOSE 8181



