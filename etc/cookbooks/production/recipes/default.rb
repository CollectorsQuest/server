# development cookbook

include_recipe "memcached"
include_recipe "nginx"
include_recipe "nginx::php-fastcgi"

include_recipe "production::zend"
include_recipe "production::vhosts"
include_recipe "production::nfs"

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
