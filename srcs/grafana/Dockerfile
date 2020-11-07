FROM alpine

LABEL maintainer="rbeach@student.21-school.com"


RUN apk update && apk add bash libc6-compat wget && \
    wget --quiet https://dl.grafana.com/oss/release/grafana-7.2.2.linux-amd64.tar.gz && \
    tar -xf grafana-7.2.2.linux-amd64.tar.gz && \
    rm -rf grafana-7.2.2.linux-amd64.tar.gz && \
    mv grafana-7.2.2 grafana && \
    mkdir /grafana/conf/provisioning/dashboards/md

ENV PATH=/grafana/bin:$PATH

WORKDIR /grafana

COPY srcs/datasource.yaml ./conf/provisioning/datasources/
COPY srcs/dashboards.yaml ./conf/provisioning/dashboards/
COPY srcs/*.json ./conf/provisioning/dashboards/md/

ENTRYPOINT grafana-server

