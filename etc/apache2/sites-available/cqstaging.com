
<VirtualHost *:80>
  ServerAlias backend.cqstaging.com

  RewriteEngine ON
  RewriteRule ^(.*)$ http://www.cqstaging.com/backend.php$1 [R=301,L]
</VirtualHost>

<VirtualHost *:80>
  ServerName  multimedia.cqstaging.com

  DocumentRoot "/www/vhosts/collectorsquest.com/stg/web"
  DirectoryIndex multimedia.php

  SetEnv  SF_APP  frontend
  SetEnv  SF_ENV  stg

  <Directory "/www/vhosts/collectorsquest.com/stg/web">
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
  ServerName    cqstaging.com
  ServerAlias *.cqstaging.com

  DocumentRoot "/www/vhosts/collectorsquest.com/stg/web"
  DirectoryIndex index.php

  CustomLog /data/logs/apache2/cqstaging.com.access.log common
  ErrorLog /data/logs/apache2/cqstaging.com.error.log

  ErrorDocument 500 /errors/500.html
  ErrorDocument 404 /errors/404.html

  SetEnv  SF_APP  frontend
  SetEnv  SF_ENV  stg

  RewriteEngine On
  RewriteCond %{HTTP_HOST} ^cqstaging.com$ [NC]
  RewriteRule ^/(.*)$ http://www.cqstaging.com/$1 [R=301,L]

  Alias /assets   "/www/vhosts/collectorsquest.com/stg/plugins/iceAssetsPlugin/web"
  Alias /uploads  "/www/vhosts/collectorsquest.com/shared/uploads"

  <Directory "/www/vhosts/collectorsquest.com/stg/web">
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
    Require group team aent

    Allow from 207.237.37.24
    Allow from 10.196.0.0/16
    Allow from localhost
    Allow from 127.0.0.1
    Satisfy Any
  </Location>
</VirtualHost>

