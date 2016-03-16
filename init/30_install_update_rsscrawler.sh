#!/bin/bash

[[ ! -d /config/.git ]] && (git clone https://github.com/rix1337/RSScrawler.git /config && \
chown -R abc:abc /config)

# opt out for autoupdates
[ "$ADVANCED_DISABLEUPDATES" ] && exit 0

cd /config
git pull
chown -R abc:abc /config

