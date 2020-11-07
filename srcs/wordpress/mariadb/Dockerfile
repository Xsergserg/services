FROM alpine
ENV ADMIN="rbeach"
LABEL maintainer="rbeach@student.21-school.com"

RUN apk add mysql bash
RUN mkdir /run/mysqld

COPY mysql.sql ./tmp
COPY start.sh ./tmp/startsql.sh


EXPOSE 3306

ENTRYPOINT sh /tmp/startsql.sh