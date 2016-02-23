#!/bin/bash
#If variable $ADVANCED_DEV_BRANCH, set branch to DEV, otherwise, default to master
[ "$ADVANCED_DEV_BRANCH" ] && BRANCH="dev" || BRANCH="master"
#Display Warning message
[ "$ADVANCED_DEV_BRANCH" ] && echo "BRANCH IS DEV, NO DOCKER SUPPORT WITH THIS BRANCH, THANKS"
echo "Cloning $BRANCH branch..."
[[ ! -d /opt/plexpy/.git ]] && (git clone https://github.com/drzoidberg33/plexpy.git --branch $BRANCH /opt/plexpy && \
chown -R abc:abc /config)

# opt out for autoupdates
[ "$ADVANCED_DISABLEUPDATES" ] && exit 0

cd /opt/plexpy
git pull
chown -R abc:abc /config

