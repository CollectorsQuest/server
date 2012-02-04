<VirtualHost *:80>
  ServerName  cqcdns.com

  DocumentRoot "/www/vhosts/cqcdns.com/web"
  DirectoryIndex index.html index.php

  ErrorLog /dev/null
  CustomLog /dev/null common

  ServerSignature Off

  <Directory "/www/vhosts/cqcdns.com/web">
    Options -Indexes 
    Allow from All
  </Directory>
</VirtualHost>

<VirtualHost *:80>
  ServerName  assets.cqcdns.com

  DocumentRoot "/www/vhosts/cqcdns.com/iceAssetsPlugin/web"
  DirectoryIndex index.html index.php

  ErrorLog /dev/null
  CustomLog /dev/null common

  ServerSignature Off

  <Directory "/www/vhosts/cqcdns.com/iceAssetsPlugin/web">
    Options -Indexes
    Allow from All
  </Directory>
</VirtualHost>

<VirtualHost *:80>
  ServerName  backend.cqcdns.com

  DocumentRoot "/www/vhosts/cqcdns.com/iceBackendPlugin/web"
  DirectoryIndex index.html index.php

  ErrorLog /dev/null
  CustomLog /dev/null common

  ServerSignature Off

  <Directory "/www/vhosts/cqcdns.com/iceBackendPlugin/web">
    Options -Indexes
    Allow from All
  </Directory>
</VirtualHost>

