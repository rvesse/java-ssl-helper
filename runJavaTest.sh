#!/usr/bin/env bash

SCRIPT_DIR=$(dirname ${BASH_SOURCE[0]})
SCRIPT_DIR=$(cd ${SCRIPT_DIR} && pwd)

# Check required tools are available
REQUIRED_TOOLS=( "java" )
for TOOL in ${REQUIRED_TOOLS[@]}; do
  command -v ${TOOL} >/dev/null 2>&1
  if [ $? -ne 0 ]; then
    echo "This script requires ${TOOL} available on your system"
    exit 1
  fi
done

exec java -cp ${SCRIPT_DIR}/classes/ ConnectionTest "$@"
