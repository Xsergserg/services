FROM alpine

LABEL maintainer="rbeach@student.21-school.com"

RUN apk update && apk add \
			nginx\
			wget\
			unzip\
			supervisor\
			bash

RUN apk add php7 php7-mcrypt php7-soap php7-apcu php7-pdo_mysql php7-cgi php7-bcmath php7-bz2 php7-ctype php7-curl php7-dom php7-enchant php7-exif php7-fpm php7-gd php7-gettext php7-gmp php7-iconv php7-imap php7-intl php7-json php7-mbstring php7-opcache php7-openssl php7-phar php7-posix php7-pspell php7-recode php7-session php7-simplexml php7-sockets php7-sysvmsg php7-sysvsem php7-sysvshm php7-tidy php7-xml php7-xmlreader php7-xmlrpc php7-xmlwriter php7-xsl php7-zip php7-sqlite3 php7-dba php7-sqlite3 php7-mysqli php7-mysqlnd php7-pgsql php7-pdo_dblib php7-pdo_odbc php7-pdo_pgsql php7-pdo_sqlite

RUN adduser -D -g 'www' www && \
	mkdir -p tmp/test.com/html && \
	chown -R www:www /var/lib/nginx && \
	chown -R www:www tmp/test.com/html &&\
	mkdir /var/run/nginx && touch /var/run/nginx/nginx.pid

RUN wget https://wordpress.org/wordpress-5.4.1.zip &&\
	unzip -q wordpress-5.4.1.zip &&\
	cp -r wordpress/. tmp/test.com/html/ &&\
	rm wordpress-5.4.1.zip &&\
	rm -R wordpress

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

COPY nginx.conf /etc/nginx/
COPY wp-config.php tmp/test.com/html/
COPY php.ini /etc/php7/php.ini
COPY www.conf /etc/php7/php-fpm.d/www.conf
COPY supervisord.conf /tmp/supervisord.conf

COPY start.sh ./tmp
RUN chmod +x /tmp/start.sh

ENTRYPOINT sh /tmp/start.sh