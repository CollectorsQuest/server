
<VirtualHost *:80>
  ServerAlias backend.collectorsquest.com

  RewriteEngine ON
  RewriteRule ^(.*)$ http://www.collectorsquest.com/backend.php$1 [R=301,L]
</VirtualHost>

<VirtualHost *:80>
  ServerName  multimedia.collectorsquest.com

  ErrorLog /dev/null
  CustomLog /dev/null common

  DocumentRoot "/www/vhosts/collectorsquest.com/current/web"
  DirectoryIndex multimedia.php

  SetEnv  SF_APP  frontend
  SetEnv  SF_ENV  prod

  <Directory "/www/vhosts/collectorsquest.com/current/web">
    AllowOverride None
    Order allow,deny
    Allow from all

    RewriteEngine On
    RewriteRule ^(.*)$ multimedia.php [QSA,L]
  </Directory>

  <Files multimedia.php>
    XSendFile on
    XSendFilePath /www/vhosts/collectorsquest.com/shared
  </Files>
</VirtualHost>

<VirtualHost *:80>
  ServerName   collectorsquest.com
  ServerAlias  *.collectorsquest.com
  ServerAlias  static.collectorsquest.com
  ServerAlias  d2y8496azcwpd6.cloudfront.net
  ServerAlias  web-471984672.us-east-1.elb.amazonaws.com

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
  RewriteCond %{HTTPS} !=on
  RewriteCond %{HTTP_HOST} !cloudfront\.net [NC]
  RewriteCond %{HTTP_HOST} !elb\.amazonaws\.com [NC]
  RewriteCond %{HTTP_HOST} !^static\.collectorsquest\.com$ [NC]
  RewriteCond %{HTTP_HOST} !^www\.collectorsquest\.com$ [NC]
  RewriteRule ^ http://www.collectorsquest.com%{REQUEST_URI} [R=301,L]

  ExpiresActive on
  ExpiresByType application/javascript "access plus 1 months"
  ExpiresByType image/jpg "access plus 1 month"
  ExpiresByType image/jpeg "access plus 1 month"
  ExpiresByType image/gif "access plus 1 month"
  ExpiresByType image/png "access plus 1 month"
  ExpiresByType text/css "access plus 1 months"


  ExpiresActive on
  ExpiresByType application/javascript "access plus 1 months"
  ExpiresByType image/jpg "access plus 1 month"
  ExpiresByType image/jpeg "access plus 1 month"
  ExpiresByType image/gif "access plus 1 month"
  ExpiresByType image/png "access plus 1 month"
  ExpiresByType text/css "access plus 1 months"

  Alias /assets   "/www/vhosts/collectorsquest.com/current/plugins/iceAssetsPlugin/web"
  Alias /uploads  "/www/vhosts/collectorsquest.com/shared/uploads"

  <Directory "/www/vhosts/collectorsquest.com/current/web">
    AllowOverride All
    Allow from all
  </Directory>

  <Directory "/www/vhosts/collectorsquest.com/*/web/xhprof">
    Deny from all
  </Directory>
</VirtualHost>
