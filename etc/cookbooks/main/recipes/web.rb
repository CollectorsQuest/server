# web cookbook

include_recipe "zend"
include_recipe "zend::browscap"
include_recipe "zend::translit"
include_recipe "zend::xhprof"
include_recipe "zend::xsendfile"

# include_recipe "zend::gearman"
# include_recipe "zend::passenger"
# include_recipe "zend::functional"
# include_recipe "zend::scached"

template "/etc/yum.repos.d/nodejs.repo" do
  mode "0644"
end

package "npm"
bash "Install lessc" do
  code <<-EOH
    ln -s /usr/bin/nodejs /usr/bin/node

    npm install less@1.3.3
    npm install less@1.3.3 -g
    npm install clean-css
    npm install clean-css -g
    gem install watchr
  EOH
  not_if "which less && which watchr"
end

bash "Install Symfony 1.4.x from PEAR" do
  code <<-EOH
    /usr/local/zend/bin/pear update-channels
    /usr/local/zend/bin/pear channel-discover pear.symfony-project.com
    /usr/local/zend/bin/pear upgrade symfony/symfony
  EOH
end

bash "Update /www permissions" do
  code <<-EOH
    chmod -R 777 /www/tmp
    chown -R apache:apache /www/tmp
    chown -R apache:apache /www/logs
    chown -R sphinx:sphinx /www/logs/sphinx
    chown -R apache:apache /www/vhosts/collectorsquest.com/shared
  EOH
end

service "zend" do
  action :restart
end
