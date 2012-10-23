server {
  listen       81;
  server_name  multimedia.cqcdns.com  Multimedia-873635319.us-east-1.elb.amazonaws.com;
  root         /www/vhosts/collectorsquest.com/current/web;
  index        multimedia.php;

  set  $sf_root_dir  /www/vhosts/collectorsquest.com/current;
  set  $sf_app       frontend;
  set  $sf_env       prod;
  set  $sf_cache     ""; 

  location /uploads/ {
    alias /www/vhosts/collectorsquest.com/current/web/uploads/;
  }

  error_page  404 = /multimedia.php;

  include /www/etc/nginx/php-5.3.x.conf;
}

