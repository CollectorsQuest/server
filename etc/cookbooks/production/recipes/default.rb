# development cookbook

require_recipe "memcached"

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

