# development cookbook

template "/etc/yum.repos.d/epel.repo" do
  mode "0644"
end

template "/etc/yum.repos.d/remi.repo" do
  mode "0644"
end

include_recipe "subversion"
include_recipe "memcached"

include_recipe "development::zend"
include_recipe "development::vhosts"
include_recipe "development::gearman"
include_recipe "development::vim"
include_recipe "development::timecards"

service "apache" do
  action :restart
end

template "/etc/hosts" do
  mode "0644"
end

package "sendmail"
package "rubygems"

bash "Install Capifony" do
  code <<-EOH
    /usr/bin/gem install --no-rdoc --no-ri capistrano
    /usr/bin/gem install --no-rdoc --no-ri capifony
  EOH
end

service "zend" do
  action :restart
end
