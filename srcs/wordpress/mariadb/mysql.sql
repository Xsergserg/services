CREATE DATABASE IF NOT EXISTS wordpressdb;
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' IDENTIFIED BY '123';
GRANT ALL PRIVILEGES ON wordpressdb.* TO 'wpadmin'@'%' IDENTIFIED BY '123';