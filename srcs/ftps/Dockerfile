FROM alpine:3.11

LABEL maintainer="rbeach@student.21-school.com"

RUN apk add vsftpd supervisor bash && \
    adduser -D test -h\ftp && passwd -d test && chown test /ftp && chmod 757 /ftp && \
    touch /ftp/example.txt && echo "FTPS server is working" >> /ftp/example.txt && \
    mkdir -p /var/run/vsftpd/empty


COPY vsftpd.conf tmp/vsftpd.conf
COPY test.key /tmp/test.key
COPY test.crt /tmp/test.crt
COPY supervisord.conf /tmp/supervisord.conf

EXPOSE 20 21 31000

ENTRYPOINT supervisord -c /tmp/supervisord.conf