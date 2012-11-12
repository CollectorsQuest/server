link "/etc/httpd/conf.d/collectorsquest.com.conf" do
  to "/www/etc/apache2/sites-available/collectorsquest.com"
  not_if "test -L /etc/httpd/conf.d/collectorsquest.com.conf"
  notifies :restart, "service[httpd]"
end

# link "/etc/httpd/conf.d/cqcdns.com.conf" do
#   to "/www/etc/apache2/sites-available/cqcdns.com"
#   not_if "test -L /etc/httpd/conf.d/cqcdns.com.conf"
#   notifies :restart, "service[httpd]"
# end

link "/www/vhosts/collectorsquest.com/current" do
  to "/www/vhosts/collectorsquest.com/releases/master"
  not_if "test -L /www/vhosts/collectorsquest.com/current"
end

link "/www/vhosts/collectorsquest.com/current/config/secure" do
  to "/www/vhosts/collectorsquest.com/shared/secure"
  not_if "test -e /www/vhosts/collectorsquest.com/current/config/secure"
end

link "/www/vhosts/collectorsquest.com/current/config/databases.yml" do
  to "/www/vhosts/collectorsquest.com/shared/secure/databases.yml"
  not_if "test -e /www/vhosts/collectorsquest.com/current/config/databases.yml"
end

bash "Initialize collectorsquest.com" do
  code <<-EOH
    cd /www/vhosts/collectorsquest.com/current
    ./console/init master
  EOH
end

