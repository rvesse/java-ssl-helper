FROM openjdk:11-jre-slim

RUN apt-get update && apt-get install -y curl openssl bash sudo

RUN mkdir -p /opt/java/ssl-helper/classes/ && chmod -R 0755 /opt/java/ssl-helper
COPY *.sh /opt/java/ssl-helper/
COPY *.class /opt/java/ssl-helper/classes/

WORKDIR /opt/java/ssl-helper/
ENTRYPOINT /bin/bash
