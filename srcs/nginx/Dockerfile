FROM alpine
LABEL maintainer="rbeach@student.21-school.com"

RUN apk update && apk add \
                            nginx \
                            openssh \
                            bash \
                            supervisor

COPY nginx.conf ./tmp
COPY id_rbeachserver.pub ./tmp/id_rbeachserver.pub
COPY test.key /tmp/test.key
COPY test.crt /tmp/test.crt
COPY index.html ./tmp
COPY supervisord.conf /tmp/supervisord.conf

RUN mkdir run/nginx && touch run/nginx/nginx.pid &&\
    adduser -D test && echo "test:123" | chpasswd &&\
    mkdir /home/test/.ssh && cp /tmp/id_rbeachserver.pub /home/test/.ssh/authorized_keys &&\
    mv -f /tmp/nginx.conf /etc/nginx/nginx.conf && \
    mkdir -p www/test.com && \
    mv -f /tmp/index.html /www/test.com/index.html && \
    ssh-keygen -A

EXPOSE 80 443 450

CMD supervisord -c /tmp/supervisord.conf