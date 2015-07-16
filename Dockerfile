FROM phusion/baseimage:0.9.16
MAINTAINER Your Name <your@email.com>
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root
ENV TERM screen


#Applying stuff
RUN apt-get update -q 
RUN apt-get install -y git python
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /var/tmp/*


#Adding Custom files
ADD init/ /etc/my_init.d/
ADD services/ /etc/service/
RUN chmod -v +x /etc/service/*/run && chmod -v +x /etc/my_init.d/*.sh

#Adding abc user
RUN useradd -u 911 -U -s /bin/false abc && usermod -G users abc

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]


# Volums and Ports
VOLUME /config
VOLUME /logs
EXPOSE 8181


## NOTES ##
## Delete files\folders not needed, e.g. if you dont run any cron commands, delete the cron folder and the "ADD cron/ /etc/cron.d/" line. 
## The User abc, should be running everything, give that permission in any case you need it. 
## Do not upgrade the baseimage before we get a chance to look at it from a wholeheartly perspective. 
## When creating init's Use 10's where posible, its to allow add stuff in between when needed. also, do not be afraid to split custom code into several little once. 
## Make stuff as quite as posible "e.g. apt-get update -qq" (Does not apply to the "app" itself. e.g. plex)