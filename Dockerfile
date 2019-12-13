FROM maven:3.6.3-jdk-8-slim AS build
RUN apt-get update && apt-get install git -y
RUN git clone https://github.com/boundary/zoocreeper.git /backup-tool
RUN mvn -f /backup-tool/pom.xml clean package

FROM alpine:3.7 AS builder
RUN apk update && apk add python2 python2-dev py2-pip alpine-sdk linux-headers && \
	pip install --user python-keystoneclient python-swiftclient 

FROM openjdk:8-jre-alpine
ENV MODE="Backup"
ENV TAG=""
ENV ST_AUTH_VERSION=3
COPY --from=build /backup-tool/target/zoocreeper-1.0-SNAPSHOT.jar /backup-tool/zoocreeper-1.0-SNAPSHOT.jar
COPY --from=builder /root/.local /usr/
RUN apk add --update python2 py2-pip && rm -rf /var/cache/apk/*

WORKDIR /backup-tool

COPY scripts/run.sh /scripts/
RUN chmod +x /scripts/run.sh \
    && sed -i -e 's/\r$//' /scripts/run.sh

ENTRYPOINT ["/scripts/run.sh"]