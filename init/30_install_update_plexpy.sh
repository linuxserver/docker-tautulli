#!/bin/bash
#If variable $ADVANCED_GIT_BRANCH, set branch to DEV, otherwise, default to master
[ "$ADVANCED_GIT_BRANCH" ] && $GIT_BRANCH=$ADVANCED_GIT_BRANCH && \
echo "BRANCH: $ADVANCED_GIT_BRANCH, Warning! This is unsupported."|| GIT_BRANCH="master"


[[ ! -d /opt/plexpy/.git ]] && (echo "Cloning $GIT_BRANCH branch..." && \
git clone https://github.com/drzoidberg33/plexpy.git --branch $GIT_BRANCH /opt/plexpy && \
chown -R abc:abc /config)

# opt out for autoupdates
[ "$ADVANCED_DISABLEUPDATES" ] && exit 0

cd /opt/plexpy
git pull
chown -R abc:abc /config
