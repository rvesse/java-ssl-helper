#!/bin/sh
#
# Usage is install-cert.sh file.cert alias [password]
#
# Installs a certificate into the system keystone which requires sudo, use the
# install-cert-local.sh if you don't have sudo privileges or only want to modify
# your local keystore
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

# Determine where the Keystore file is
# Depending on the OS and the install this might be in a couple
# of different places under JAVA_HOME
KEYSTORE=
if [ -f "${JAVA_HOME}/lib/security/cacerts" ]; then
  KEYSTORE="${JAVA_HOME}/lib/security/cacerts"
elif [ -f "${JAVA_HOME}/jre/lib/security/cacerts" ]; then
  KEYSTORE="${JAVA_HOME}/jre/lib/security/cacerts"
fi

if [ -z "${KEYSTORE}" ]; then
  echo "Unable to find JVM Key store, are you sure JAVA_HOME is set correctly?"
  exit 1
fi

# Actually install the key into the key store
echo "NB - If a password prompt appears it is in order to grant sudo privileges so this script can modify the JVM key store which typically lives in a system directory owned by root"
set +x
sudo keytool -import -noprompt -trustcacerts -alias ${ALIAS} -file ${CERT} -keystore "${KEYSTORE}" -storepass ${PASSWORD}
if [ $? -ne 0 ]; then
  exit 1
fi

