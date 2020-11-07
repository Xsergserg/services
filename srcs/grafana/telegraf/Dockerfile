FROM alpine

LABEL maintainer="rbeach@student.21-school.com"

RUN apk update && apk add libc6-compat bash
RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-1.16.0_linux_amd64.tar.gz
RUN tar -xf telegraf-1.16.0_linux_amd64.tar.gz
RUN mv telegraf-1.16.0 telegraf

RUN cp -r telegraf/etc/* /etc/ && cp -r telegraf/usr/lib/* /usr/lib/ && \
    cp -r telegraf/usr/bin/* /usr/bin/ && cp -r telegraf/var/log/* /var/log/

RUN rm -rf telegraf-1.16.0_linux_amd64.tar.gz
RUN rm -rf telegraf

COPY telegraf.conf /tmp

ENTRYPOINT telegraf --config /tmp/telegraf.conf