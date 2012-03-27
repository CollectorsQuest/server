<VirtualHost *:80>
  ServerName  cqnext.com
  ServerAlias www.cqnext.com

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
    Allow from All
  </Directory>
</VirtualHost>

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
  ServerName  next.cqcdns.com

  DocumentRoot "/www/vhosts/cqcdns.com/next/web"
  DirectoryIndex index.html index.php

  ErrorLog /dev/null
  CustomLog /dev/null common

  ServerSignature Off

  Alias /assets/  /www/vhosts/cqcdns.com/next/iceAssetsPlugin/web/
  Alias /backend/ /www/vhosts/cqcdns.com/next/iceBackendPlugin/web/

  <Directory "/www/vhosts/cqcdns.com/next/web">
    Options -Indexes
    Allow from All
  </Directory>
</VirtualHost>

