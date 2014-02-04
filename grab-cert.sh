#!/bin/sh
# usage: grab-cert.sh remote.host.name [port]
#
# Based on example by Paul Heinlein from http://www.madboa.com/geek/openssl/#cert-retrieve
# and used under the CC-BY-NC-SA license

REMHOST=$1
REMPORT=${2:-443}

if [ -z ${REMHOST} ]; then
  echo "No host specified"
  exit 1
fi

echo |\
openssl s_client -connect ${REMHOST}:${REMPORT} 2>&1 |\
sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p'