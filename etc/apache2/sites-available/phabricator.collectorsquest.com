<VirtualHost *:80>
  # Change this to the domain which points to your host, i.e. the domain
  # you set as "phabricator.base-uri".
  ServerName phabricator.collectorsquest.com

  ErrorLog /dev/null
  CustomLog /dev/null combined

  ServerSignature Off

  # Change this to the path where you put 'phabricator' when you checked it
  # out from github when following the Installation Guide.
  DocumentRoot /opt/phabricator/phabricator/webroot

  RewriteEngine on
  RewriteRule ^/rsrc/(.*)     -                       [L,QSA]
  RewriteRule ^/favicon.ico   -                       [L,QSA]
  RewriteRule ^(.*)$          /index.php?__path__=$1  [L,QSA]

  # This will use the config file you set up in the previous step. If you
  # called it something other than 'myconfig', put that here.
  SetEnv PHABRICATOR_ENV collectorsquest
</VirtualHost>
