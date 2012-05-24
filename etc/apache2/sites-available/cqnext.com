
<VirtualHost *:80>
  ServerAlias backend.cqnext.com

  DocumentRoot "/www/vhosts/collectorsquest.com/next/web"
  DirectoryIndex index.php

  CustomLog /data/logs/apache2/cqnext.com.access.log common
  ErrorLog /data/logs/apache2/cqnext.com.error.log

  ErrorDocument 500 /errors/500.html
  ErrorDocument 404 /errors/404.html

  SetEnv  SF_APP  backend
  SetEnv  SF_ENV  next

  <Directory "/www/vhosts/collectorsquest.com/next/web">
    AllowOverride All
    Allow from All
  </Directory>
</VirtualHost>

<VirtualHost *:80>
  ServerName  multimedia.cqnext.com

  DocumentRoot "/www/vhosts/collectorsquest.com/next/web"
  DirectoryIndex multimedia.php

  SetEnv  SF_APP  frontend
  SetEnv  SF_ENV  next

  <Directory "/www/vhosts/collectorsquest.com/next/web">
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
  ServerName    cqnext.com
  ServerAlias *.cqnext.com

  DocumentRoot "/www/vhosts/collectorsquest.com/next/web"
  DirectoryIndex index.php

  CustomLog /data/logs/apache2/cqnext.com.access.log common
  ErrorLog /data/logs/apache2/cqnext.com.error.log

  ErrorDocument 500 /errors/500.html
  ErrorDocument 404 /errors/404.html

  SetEnv  SF_APP  frontend
  SetEnv  SF_ENV  next

  RewriteEngine On
  RewriteCond %{HTTP_HOST} ^cqnext.com$ [NC]
  RewriteRule ^/(.*)$ http://www.cqnext.com/$1 [R=301,L]

  Alias /assets   "/www/vhosts/collectorsquest.com/next/plugins/iceAssetsPlugin/web"
  Alias /uploads  "/www/vhosts/collectorsquest.com/shared/uploads"

  <Directory "/www/vhosts/collectorsquest.com/next/web">
    AllowOverride All
  </Directory>

  <Location />
    Order deny,allow
    Deny from all

    AuthType Basic
    AuthName "By Invitation Only"
    AuthBasicProvider file
    AuthUserFile /www/etc/apache2/htpasswd
    AuthGroupFile /www/etc/apache2/htgroups
    Require group CollectorsQuestTeam

    Allow from 207.237.37.24
    Allow from 95.87.220.50
    Satisfy Any
  </Location>
</VirtualHost>

