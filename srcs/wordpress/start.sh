#!/bin/bash
cd /tmp/test.com/html

wp core install --url="172.17.0.10:5050"  --title="test site" --admin_user="admin" --admin_password="123" --admin_email="admin@admin.ru" --allow-root
wp user create test1 test1@test1.ru --allow-root
wp user create test2 test2@test2.ru --allow-root

supervisord -c /tmp/supervisord.conf