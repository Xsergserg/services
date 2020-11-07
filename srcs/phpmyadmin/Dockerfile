FROM alpine

LABEL maintainer="rbeach@student.21-school.com"

RUN apk update && apk add \
			nginx\
			wget\
			unzip\
			phpmyadmin\
			supervisor\
			bash

RUN apk add php7 php7-fpm php7-mcrypt php7-soap php7-openssl php7-gmp php7-pdo_odbc php7-json php7-dom php7-pdo php7-zip php7-mysqli php7-sqlite3 php7-apcu php7-pdo_pgsql php7-bcmath php7-gd php7-odbc php7-pdo_mysql php7-pdo_sqlite php7-gettext php7-xmlreader php7-xmlrpc php7-bz2 php7-iconv php7-pdo_dblib php7-curl php7-ctype php7-session

RUN adduser -D -g 'www' www && \
	mkdir -p tmp/test.com && \
	chown -R www:www /var/lib/nginx && \
	mv /usr/share/webapps/phpmyadmin tmp/test.com/html &&\
	chown -R www:www tmp/test.com/html && \
	mkdir /var/run/nginx && touch /var/run/nginx/nginx.pid &&\
	rm /etc/php7/php-fpm.d/www.conf && rm /etc/php7/php.ini

COPY nginx.conf /etc/nginx/
COPY config.inc.php tmp/test.com/html/config.inc.php
COPY php.ini /etc/php7/php.ini
COPY www.conf /etc/php7/php-fpm.d/www.conf
COPY supervisord.conf /tmp/supervisord.conf

CMD supervisord -c /tmp/supervisord.conf