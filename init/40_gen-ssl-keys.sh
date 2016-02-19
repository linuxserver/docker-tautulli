#!/bin/bash
[ "$NO_SELF_SIGN_CERT" ] && { echo "NOT creating Self Signed certificate"; exit 0; }

SUBJECT="//C=US/ST=CA/L=Carlsbad/O=Linuxserver.io/OU=LSIO Server/CN=*"
if [[ -f /config/server.key && -f /config/server.crt ]]; then
  echo "Using keys found in /config/"
else
  echo "generating self-signed keys in /config/, you can replace by your own."
  /sbin/setuser abc openssl req -new -x509 -days 3650 -nodes -out /config/server.crt -keyout /config/server.key -subj "$SUBJECT"
fi
