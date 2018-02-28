# Dockerfile
# AixViPMaP Web
# (c) 2016-18 ICMEaix RWTH Aachen University
FROM centos:7
MAINTAINER Lukas Koschmieder <lukas.koschmieder@rwth-aachen.de>

RUN yum update -y

### Apache2

RUN yum install -y httpd mod_ssl

### PHP 5.6

RUN yum install -y centos-release-scl

RUN yum install -y rh-php56 rh-php56-php rh-php56-php-gd rh-php56-php-intl rh-php56-php-mbstring rh-php56-php-mysqlnd httpd24

RUN rm -f /etc/httpd/conf.d/php.config
RUN rm -f /etc/httpd/conf.modules.d/php.config

RUN cp /opt/rh/httpd24/root/etc/httpd/conf.d/rh-php56-php.conf /etc/httpd/conf.d/
RUN cp /opt/rh/httpd24/root/etc/httpd/conf.modules.d/10-rh-php56-php.conf /etc/httpd/conf.modules.d/
RUN cp /opt/rh/httpd24/root/etc/httpd/modules/librh-php56-php5.so /etc/httpd/modules/

### ownCloud 10

RUN rpm --import https://download.owncloud.org/download/repositories/10.0/CentOS_7/repodata/repomd.xml.key
RUN yum-config-manager --add-repo https://download.owncloud.org/download/repositories/10.0/CentOS_7/ce:10.0.repo

RUN yum clean expire-cache
RUN yum install -y owncloud-files

### AixViPMaP ownCloud apps

RUN yum -y install git
RUN git clone --depth=1 --branch=master https://github.com/AixViPMaP/aixvipmap_theme.git /var/www/html/owncloud/apps/aixvipmap_theme
RUN git clone --depth=1 --branch=master https://github.com/AixViPMaP/inline_menu.git /var/www/html/owncloud/apps/inline_menu

RUN rm -rf /var/www/html/owncloud/apps/aixvipmap_theme/.git
RUN rm -rf /var/www/html/owncloud/apps/inline_menu/.git

RUN chown -R apache. /var/www/html/owncloud/apps/aixvipmap_theme
RUN chown -R apache. /var/www/html/owncloud/apps/inline_menu

RUN find /var/www/html/owncloud/apps/aixvipmap_theme -type f -exec chmod 640 {} \;
RUN find /var/www/html/owncloud/apps/aixvipmap_theme -type d -exec chmod 750 {} \;
RUN find /var/www/html/owncloud/apps/inline_menu -type f -exec chmod 640 {} \;
RUN find /var/www/html/owncloud/apps/inline_menu -type d -exec chmod 750 {} \;

### Misc

RUN yum install -y sudo

### Config

COPY apache2/aixvipmap.conf /etc/httpd/conf.d/
COPY apache2/ssl.conf /etc/httpd/conf.d/

COPY apache2/cert.pem /etc/httpd/
COPY apache2/chain.pem /etc/httpd/
COPY apache2/key.pem /etc/httpd/

RUN chmod 600 /etc/httpd/*.pem

COPY ./owncloud-setup.sh /
COPY ./docker-entrypoint.sh /
