#!/bin/bash


if [ ! -d /opt/plexpy/.git ]; then
	git clone https://github.com/drzoidberg33/plexpy.git /opt/plexpy
else
	cd /opt/plexpy
	git pull
fi

chown -R abc:abc /config
