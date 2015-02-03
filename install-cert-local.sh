#!/bin/sh
#
# Usage is install-cert.sh file.cert alias [password]
#
# Installs a certificate in your local keystore which should not require sudo
# privileges to modify
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

set +x
keytool -import -noprompt -trustcacerts -alias ${ALIAS} -file ${CERT} -storepass ${PASSWORD}

