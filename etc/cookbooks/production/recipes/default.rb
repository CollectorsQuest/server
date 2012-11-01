# development cookbook

require_recipe "memcached"
require_recipe "nginx"
require_recipe "nginx::php-fastcgi"

require_recipe "production::zend"
require_recipe "production::vhosts"
require_recipe "production::nfs"

template "/etc/hosts" do
  mode "0644"
end

service "httpd" do
  action :restart
end

service "zend-server" do
  action :restart
end

service "nginx" do
  action :restart
end

service "php-fpm" do
  action :restart
end
