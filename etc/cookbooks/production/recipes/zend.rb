template "/usr/local/zend/etc/conf.d/production.ini" do
  source "production.ini"
  mode "0664"
end

link "/var/log/apache2" do
  to "/var/log/httpd"
  not_if "test -L /var/log/apache2"
end

directory "/data/logs/apache2" do
  owner "apache"
  group "apache"
  mode "0655"
  recursive true
  action :create
end

