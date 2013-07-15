#!/bin/sh
#
# Usage is install-cert.sh file.cert alias [password]
#
# If no password specified the default "changeit" is assumed
# This is correct for OS X with the standard JVM installed but may vary by OS and JVM

CERT=$1
ALIAS=$2
PASSWORD=${3:-changeit}

if [ -z ${CERT} ]; then
  echo "No certificate file specified"
  exit 1
fi

if [ -z ${ALIAS} ]; then
  echo "No alias for the certificate was specified"
  exit 1
fi

if [ -z ${JAVA_HOME} ]; then
  echo "Required environment variable JAVA_HOME is not set"
  exit 1
fi

echo "NB - If a password prompt it appears it is to grant sudo privileges so this script can modify the JVM key store"
sudo keytool -import -noprompt -trustcacerts -alias ${ALIAS} -file ${CERT} -keystore "${JAVA_HOME}/lib/security/cacerts" -storepass ${PASSWORD}

