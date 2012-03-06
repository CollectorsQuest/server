<VirtualHost *:80>
  ServerName  cqstaging.com
  ServerAlias www.cqstaging.com

  DocumentRoot "/www/vhosts/collectorsquest.com/staging/web"
  DirectoryIndex index.php

  CustomLog /data/logs/apache2/cqstaging.com.access.log common
  ErrorLog /data/logs/apache2/cqstaging.com.error.log

  ErrorDocument 500 /errors/500.html
  ErrorDocument 404 /errors/404.html

  SetEnv  SF_APP  legacy
  SetEnv  SF_ENV  stg

  RewriteEngine On
  RewriteCond %{HTTP_HOST} ^cqstaging.com$ [NC]
  RewriteRule ^/(.*)$ http://www.cqstaging.com/$1 [R=301,L]

  <Directory "/www/vhosts/collectorsquest.com/staging/web">
    
    AuthType Basic
    AuthName "By Invitation Only"
    AuthBasicProvider file
    AuthUserFile /www/etc/apache2/htpasswd
    AuthGroupFile /www/etc/apache2/htgroups
    Require group CollectorsQuestTeam

    AllowOverride All
    Allow from All
  </Directory>
</VirtualHost>

<VirtualHost *:80>
  ServerAlias backend.cqstaging.com

  DocumentRoot "/www/vhosts/collectorsquest.com/staging/web"
  DirectoryIndex index.php

  CustomLog /data/logs/apache2/cqstaging.com.access.log common
  ErrorLog /data/logs/apache2/cqstaging.com.error.log

  ErrorDocument 500 /errors/500.html
  ErrorDocument 404 /errors/404.html

  SetEnv  SF_APP  backend
  SetEnv  SF_ENV  stg

  <Directory "/www/vhosts/collectorsquest.com/staging/web">
    AllowOverride All
    Allow from All
  </Directory>
</VirtualHost>

<VirtualHost *:80>
  ServerName  multimedia.cqstaging.com

  DocumentRoot "/www/vhosts/collectorsquest.com/staging/web"
  DirectoryIndex multimedia.php

  <Directory "/www/vhosts/collectorsquest.com/staging/web">
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

