FROM linuxserver/baseimage.python
MAINTAINER rix1337

#Adding Custom files
ADD init/ /etc/my_init.d/
ADD services/ /etc/service/
RUN chmod -v +x /etc/service/*/run /etc/my_init.d/*.sh

# Install Requirements
RUN pip install -r requirements.txt

# Volumes and Ports
VOLUME /config /jd2
