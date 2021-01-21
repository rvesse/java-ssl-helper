#!/bin/sh
#
# Usage is view-cert.sh file.cert
#
# Displays the contents of a certificate at the command line

CERT=$1

if [ -z ${CERT} ]; then
  echo "No certificate file specified"
  exit 1
fi

# Display the certificate
openssl x509 -text -noout -in ${CERT}

