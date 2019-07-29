#!/usr/bin/env bash

SCRIPT_DIR=$(dirname ${BASH_SOURCE[0]})
SCRIPT_DIR=$(cd ${SCRIPT_DIR} && pwd)

# Check required tools are available
REQUIRED_TOOLS=( "docker" "javac" )
for TOOL in ${REQUIRED_TOOLS[@]}; do
  command -v ${TOOL} >/dev/null 2>&1
  if [ $? -ne 0 ]; then
    echo "This script requires ${TOOL} available on your system"
    exit 1
  fi
done

# Firstly build the Java executable
echo "Building Java test executable..."
javac "${SCRIPT_DIR}/ConnectionTest.java"
if [ $? -ne 0 ]; then
  echo "Failed to build Java test class"
  exit 1
fi
mkdir -p "${SCRIPT_DIR}/classes"
cp "${SCRIPT_DIR}/ConnectionTest.class" "${SCRIPT_DIR}/classes/"

# Then build the Docker image
echo "Building Docker image..."
docker build -t ${USER}/java-ssl-helper:latest -f ${SCRIPT_DIR}/Dockerfile ${SCRIPT_DIR}
if [ $? -ne 0 ]; then
  echo "Failed to build Docker image"
  exit 1
fi

# Finally push the Docker image
echo "Pushing Docker image..."
docker push ${USER}/java-ssl-helper:latest
if [ $? -ne 0 ]; then
  echo "Failed to push Docker image"
  exit 1
fi

echo "Completed successfully!"
exit 0
