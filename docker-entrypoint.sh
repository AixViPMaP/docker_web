#!/bin/bash
# Docker ENTRYPOINT
# Lukas Koschmieder <lukas.koschmieder@rwth-aachen.de>
# (c) 2016-18 ICMEaix RWTH Aachen University

echo "${0}"

chown apache:apache /occonfig
chown apache:apache /ocdata

occonfig=/var/www/html/owncloud/config
test -L $occonfig && unlink $occonfig
test -d $occonfig && mv $occonfig{,.orig}
ln -s /occonfig $occonfig

$skip_owncloud_setup || sudo -E -u apache bash /owncloud-setup.sh

rm -rf /run/httpd/*
rm -rf /var/run/httpd/httpd.pid
httpd -k start -D FOREGROUND

#trap : TERM INT
#sleep infinity & wait
