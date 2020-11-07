FROM alpine

LABEL maintainer="rbeach@student.21-school.com"

RUN apk update && apk add libc6-compat bash
RUN wget https://dl.influxdata.com/influxdb/releases/influxdb-1.8.3_linux_amd64.tar.gz
RUN tar -xf influxdb-1.8.3_linux_amd64.tar.gz
RUN mv influxdb-1.8.3-1 influxdb

RUN cp -r influxdb/etc/* /etc/ && cp -r influxdb/usr/lib/* /usr/lib/ && \
    cp -r influxdb/usr/bin/* /usr/bin/ && cp -r influxdb/usr/share/* /usr/share/ && cp -r influxdb/var/log/* /var/log/ && cp -r influxdb/var/lib/* /var/lib/

RUN rm -rf influxdb-1.8.3_linux_amd64.tar.gz
RUN rm -rf influxdb

ENTRYPOINT influxd