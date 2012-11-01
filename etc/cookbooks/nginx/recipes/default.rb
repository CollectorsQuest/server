#
# Cookbook Name:: nginx
# Recipe:: default
#

package "nginx"

bash "Install Nginx /etc/nginx configs" do
  code <<-EOH
    rm -rf /etc/nginx
    ln -s /www/etc/nginx /etc/nginx
    /etc/init.d/nginx restart
  EOH
  not_if "test -L /etc/nginx"
end
