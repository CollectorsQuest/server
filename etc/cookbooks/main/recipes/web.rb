# web cookbook

require_recipe "zend"
require_recipe "zend::browscap"
require_recipe "zend::translit"
require_recipe "zend::xhprof"
require_recipe "zend::xsendfile"

# require_recipe "zend::gearman"
# require_recipe "zend::passenger"
# require_recipe "zend::functional"
# require_recipe "zend::scached"

template "/etc/yum.repos.d/nodejs.repo" do
  mode "0644"
end

package "npm"
bash "Install lessc" do
  code <<-EOH
    ln -s /usr/bin/nodejs /usr/bin/node

    npm install less
    npm install less -g
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
