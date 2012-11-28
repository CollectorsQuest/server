link "/etc/httpd/conf.d/collectorsquest.dev.conf" do
  to "/www/etc/apache2/sites-available/collectorsquest.dev"
  not_if "test -L /etc/httpd/conf.d/collectorsquest.dev.conf"
  notifies :restart, "service[apache]"
end

# link "/etc/httpd/conf.d/collectorsquest.legacy.conf" do
#   to "/www/etc/apache2/sites-available/collectorsquest.legacy"
#   not_if "test -L /etc/httpd/conf.d/collectorsquest.legacy.conf"
#   notifies :restart, "service[apache]"
# end

link "/etc/httpd/conf.d/cqcdns.dev.conf" do
  to "/www/etc/apache2/sites-available/cqcdns.dev"
  not_if "test -L /etc/httpd/conf.d/cqcdns.dev.conf"
  notifies :restart, "service[apache]"
end

link "/www/vhosts/collectorsquest.dev" do
  to "/www/vhosts/collectorsquest.com"
  not_if "test -L /www/vhosts/collectorsquest.dev"
end

link "/www/vhosts/collectorsquest.com/releases/trunk" do
  to "/mnt/vhosts/collectorsquest.com"
  not_if "test -L /www/vhosts/collectorsquest.com/releases/trunk"
end

link "/www/vhosts/collectorsquest.com/current" do
  to "/www/vhosts/collectorsquest.com/releases/trunk"
  not_if "test -L /www/vhosts/collectorsquest.com/current"
end

link "/www/etc/sphinx/conf.d/collectorsquest" do
  to "/www/vhosts/collectorsquest.com/current/config/sphinx"
  not_if "test -L /www/etc/sphinx/conf.d/collectorsquest"
end

# link "/www/vhosts/collectorsquest.legacy" do
#   to "/www/vhosts/collectorsquest.com"
#   not_if "test -L /www/vhosts/collectorsquest.legacy"
# end

# link "/www/vhosts/collectorsquest.com/releases/legacy" do
#   to "/mnt/vhosts/collectorsquest.legacy"
#   not_if "test -L /www/vhosts/collectorsquest.com/releases/legacy"
# end

# link "/www/vhosts/collectorsquest.com/legacy" do
#   to "/www/vhosts/collectorsquest.com/releases/legacy"
#   not_if "test -L /www/vhosts/collectorsquest.com/legacy"
# end

# link "/www/vhosts/collectorsquest.com/legacy/config/databases.yml" do
#   to "/www/vhosts/collectorsquest.com/legacy/config/databases.dist.yml"
#   not_if "test -e /www/vhosts/collectorsquest.com/legacy/config/databases.yml"
# end

link "/www/vhosts/collectorsquest.com/current/config/databases.yml" do
  to "/www/vhosts/collectorsquest.com/current/config/databases.dist.yml"
  not_if "test -e /www/vhosts/collectorsquest.com/current/config/databases.yml"
end

link "/www/vhosts/cqcdns.dev" do
  to "/mnt/vhosts/cqcdns.com"
  not_if "test -L /www/vhosts/cqcdns.dev"
end

