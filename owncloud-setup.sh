#!/bin/bash
PATH=/opt/rh/rh-php56/root/bin:$PATH

cd /var/www/html/owncloud

php occ maintenance:install \
--database "$database" \
--database-host "$database_host" \
--database-name "$database_name" \
--database-user "$database_user" \
--database-pass "$database_pass" \
--admin-user "$admin_user" \
--admin-pass "$admin_pass" \
--data-dir "$data_dir"

php occ config:system:set trusted_domains 2 --value=$HOSTNAME
php occ config:system:set --value 1 filesystem_check_changes
php occ config:system:set --value files defaultapp
php occ config:system:set --value false --type boolean allow_user_to_change_display_name
php occ config:system:set --value false --type boolean knowledgebaseenabled

php occ app:disable activity
php occ app:disable files_videoplayer
php occ app:disable firstrunwizard

php occ app:enable aixvipmap_theme
php occ app:enable files_duplicate
php occ app:enable inline_menu
