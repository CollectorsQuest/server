<VirtualHost *:80>
  ServerName  collectorsquest.com
  ServerAlias www.collectorsquest.com

  DocumentRoot "/www/vhosts/collectorsquest.com/current/web"
  DirectoryIndex index.php

  CustomLog /data/logs/apache2/collectorsquest.com.access.log common
  ErrorLog /data/logs/apache2/collectorsquest.com.error.log

  ErrorDocument 500 /errors/500.html
  ErrorDocument 404 /errors/404.html

  SetEnv  SF_APP  frontend
  SetEnv  SF_ENV  prod 

  ServerSignature Off

  RewriteEngine On
  RewriteCond %{HTTP_HOST} ^collectorsquest.com$ [NC]
  RewriteRule ^/(.*)$ http://www.collectorsquest.com/$1 [R=301,L]

  Alias /uploads  "/www/vhosts/collectorsquest.com/shared/uploads"

  ExpiresActive on
  ExpiresByType application/javascript "access plus 1 months"
  ExpiresByType image/jpg "access plus 1 month"
  ExpiresByType image/jpeg "access plus 1 month"
  ExpiresByType image/gif "access plus 1 month"
  ExpiresByType image/png "access plus 1 month"
  ExpiresByType text/css "access plus 1 months"

  <Directory "/www/vhosts/collectorsquest.com/current/web">
    Options +FollowSymLinks
    AllowOverride All
    Order allow,deny
    Allow from all
  </Directory>

  <Directory "/www/vhosts/collectorsquest.com/*/web/xhprof">
    Deny from all
  </Directory>
</VirtualHost>

<VirtualHost *:80>
  ServerAlias backend.collectorsquest.com

  DocumentRoot "/www/vhosts/collectorsquest.com/current/web"
  DirectoryIndex index.php

  CustomLog /data/logs/apache2/collectorsquest.com.access.log common
  ErrorLog /data/logs/apache2/collectorsquest.com.error.log

  ErrorDocument 500 /errors/500.html
  ErrorDocument 404 /errors/404.html

  include /www/etc/apache2/auth.conf

  SetEnv  SF_APP  backend
  SetEnv  SF_ENV  prod

  RewriteEngine On
  RewriteCond %{HTTP_HOST} ^collectorsquest.com$ [NC]
  RewriteRule ^/(.*)$ http://www.collectorsquest.com/$1 [R=301,L]

  <Directory "/www/vhosts/collectorsquest.com/current/web">
    AllowOverride All
    Allow from All
  </Directory>
</VirtualHost>

<VirtualHost *:80>
  ServerName  multimedia.collectorsquest.com

  ErrorLog /dev/null
  CustomLog /dev/null common

  DocumentRoot "/www/vhosts/collectorsquest.com/current/web"
  DirectoryIndex multimedia.php

  <Directory "/www/vhosts/collectorsquest.com/current/web">
    AllowOverride None
    Allow from All

    RewriteEngine On
    RewriteRule ^(.*)$ multimedia.php [QSA,L]
  </Directory>

  <Files multimedia.php>
    XSendFile on
    XSendFilePath /www/vhosts/collectorsquest.com/shared
  </Files>
</VirtualHost>

<VirtualHost *:80>
  ServerName stats.collectorsquest.com

  ErrorLog /dev/null
  CustomLog /dev/null common

  DocumentRoot "/www/vhosts/stats.collectorsquest.com/web"
  DirectoryIndex awstats.collectorsquest.com.html

  <Directory "/www/vhosts/stats.collectorsquest.com/web">
   AllowOverride None
   Allow from All
  </Directory>
</VirtualHost>

