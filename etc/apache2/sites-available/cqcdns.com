<VirtualHost *:80>
  ServerName  cqcdns.com

  DocumentRoot "/www/vhosts/cqcdns.com/current/web"
  DirectoryIndex index.html index.php

  ErrorLog /dev/null
  CustomLog /dev/null common

  ServerSignature Off

  <Directory "/www/vhosts/cqcdns.com/current/web">
    Options -Indexes 
    Allow from All
  </Directory>
</VirtualHost>

<VirtualHost *:80>
  ServerName  assets.cqcdns.com

  DocumentRoot "/www/vhosts/cqcdns.com/current/iceAssetsPlugin/web"
  DirectoryIndex index.html index.php

  ErrorLog /dev/null
  CustomLog /dev/null common

  ServerSignature Off

  <Directory "/www/vhosts/cqcdns.com/current/iceAssetsPlugin/web">
    Options -Indexes
    Allow from All
  </Directory>
</VirtualHost>

<VirtualHost *:80>
  ServerName  backend.cqcdns.com

  DocumentRoot "/www/vhosts/cqcdns.com/current/iceBackendPlugin/web"
  DirectoryIndex index.html index.php

  ErrorLog /dev/null
  CustomLog /dev/null common

  ServerSignature Off

  <Directory "/www/vhosts/cqcdns.com/current/iceBackendPlugin/web">
    Options -Indexes
    Allow from All
  </Directory>
</VirtualHost>

