#!/bin/bash

mysqladmin drop collectorsquest_dev && mysqladmin create collectorsquest_dev

echo "Syncing collectorsquest_com..."
mysqldump -h master.cwvkronpbfrx.us-east-1.rds.amazonaws.com -usync -p4muNB6D47ACvfa \
--skip-opt --compress --quick --extended-insert --create-options --single-transaction --set-charset \
collectorsquest_com | mysql -u root -D collectorsquest_dev

echo "Syncing collectorsquest_blog..."
mysqldump -h master.cwvkronpbfrx.us-east-1.rds.amazonaws.com -usync -p4muNB6D47ACvfa \
--skip-opt --compress --quick --extended-insert --create-options --single-transaction --set-charset \
--ignore-table=collectorsquest_blog.propel_migration collectorsquest_blog | mysql -u root -D collectorsquest_dev

echo "Syncing collectorsquest_queue..."
mysqldump -h master.cwvkronpbfrx.us-east-1.rds.amazonaws.com -usync -p4muNB6D47ACvfa \
--skip-opt --compress --quick --extended-insert --create-options --single-transaction --set-charset \
--ignore-table=collectorsquest_queue.propel_migration collectorsquest_queue | mysql -u root -D collectorsquest_dev

echo "Fixing collectorsquest_dev.wp_options..."
echo "UPDATE wp_options SET option_value = 'http://www.collectorsquest.dev/blog' WHERE option_id = '1';" | mysql -u root -D collectorsquest_dev
echo "UPDATE wp_options SET option_value = 'http://www.collectorsquest.com/blog' WHERE option_id = '40';" | mysql -u root -D collectorsquest_dev

