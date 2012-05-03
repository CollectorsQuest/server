
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

<VirtualHost *:80>
  ServerName  assets.staging.cqcdns.com

  DocumentRoot "/www/vhosts/cqcdns.com/staging/iceAssetsPlugin/web"
  DirectoryIndex index.html index.php

  ErrorLog /dev/null
  CustomLog /dev/null common

  ServerSignature Off

  <Directory "/www/vhosts/cqcdns.com/staging/iceAssetsPlugin/web">
    Options -Indexes
    Allow from All
  </Directory>
</VirtualHost>

<VirtualHost *:80>
  ServerName  backend.staging.cqcdns.com

  DocumentRoot "/www/vhosts/cqcdns.com/staging/iceBackendPlugin/web"
  DirectoryIndex index.html index.php

  ErrorLog /dev/null
  CustomLog /dev/null common

  ServerSignature Off

  <Directory "/www/vhosts/cqcdns.com/staging/iceBackendPlugin/web">
    Options -Indexes
    Allow from All
  </Directory>
</VirtualHost>

<VirtualHost *:80>
  ServerName  staging.cqcdns.com

  DocumentRoot "/www/vhosts/cqcdns.com/staging/web"
  DirectoryIndex index.html index.php

  ErrorLog /dev/null
  CustomLog /dev/null common

  ServerSignature Off

  Alias /assets/  /www/vhosts/cqcdns.com/staging/iceAssetsPlugin/web/
  Alias /backend/ /www/vhosts/cqcdns.com/staging/iceBackendPlugin/web/

  <Directory "/www/vhosts/cqcdns.com/staging/web">
    Options -Indexes
    Allow from All
  </Directory>
</VirtualHost>


<VirtualHost *:80>
  ServerName  assets.next.cqcdns.com

  DocumentRoot "/www/vhosts/cqcdns.com/next/iceAssetsPlugin/web"
  DirectoryIndex index.html index.php

  ErrorLog /dev/null
  CustomLog /dev/null common

  ServerSignature Off

  <Directory "/www/vhosts/cqcdns.com/next/iceAssetsPlugin/web">
    Options -Indexes
    Allow from All
  </Directory>
</VirtualHost>

<VirtualHost *:80>
  ServerName  backend.next.cqcdns.com

  DocumentRoot "/www/vhosts/cqcdns.com/next/iceBackendPlugin/web"
  DirectoryIndex index.html index.php

  ErrorLog /dev/null
  CustomLog /dev/null common

  ServerSignature Off

  <Directory "/www/vhosts/cqcdns.com/next/iceBackendPlugin/web">
    Options -Indexes
    Allow from All
  </Directory>
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

<VirtualHost *:80>
  ServerName    cqcdns.com
  ServerAlias *.cqcdns.com

  DocumentRoot "/www/vhosts/cqcdns.com/current/web"
  DirectoryIndex index.html index.php

  ErrorLog /dev/null
  CustomLog /dev/null common

  ServerSignature Off

  Alias /assets/  /www/vhosts/cqcdns.com/current/iceAssetsPlugin/web/
  Alias /backend/ /www/vhosts/cqcdns.com/current/iceBackendPlugin/web/

  <Directory "/www/vhosts/cqcdns.com/current/web">
    Options -Indexes 
    Allow from All
  </Directory>
</VirtualHost>
