<VirtualHost *:80>
  ServerName deploy.collectorsquest.com
  ServerAlias deploy.collectorsquest.dev

  ErrorLog /dev/null
  CustomLog /dev/null combined

  include /www/etc/apache2/auth.conf

  DocumentRoot /www/vhosts/deploy.collectorsquest.com/public
  <Directory /www/vhosts/deploy.collectorsquest.com/public>
    AllowOverride all
    Options -MultiViews
  </Directory>
</VirtualHost>
