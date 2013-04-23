#!/bin/bash
export DATE=`date "+%Y-%m-%d-at-%Hh"`

echo "Dumping collectorsquest_com..."
mysqldump -uroot \
  --skip-opt --quick --extended-insert --create-options --single-transaction \
  --set-charset collectorsquest_com |gzip > collectorsquest_com_$DATE.sql.gz

echo "Dumping collectorsquest_blog..."
mysqldump -uroot \
  --skip-opt --quick --extended-insert --create-options --single-transaction \
  --set-charset --ignore-table=collectorsquest_blog.propel_migration collectorsquest_blog |gzip > collectorsquest_blog_$DATE.sql.gz

echo "Dumping collectorsquest_queue..."
mysqldump -uroot \
  --skip-opt --quick --extended-insert --create-options --single-transaction \
  --set-charset --ignore-table=collectorsquest_queue.propel_migration collectorsquest_queue |gzip > collectorsquest_queue_$DATE.sql.gz

~                                                          

