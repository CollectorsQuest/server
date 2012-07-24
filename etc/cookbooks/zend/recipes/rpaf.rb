include_recipe "zend"
package "httpd-devel"

remote_file "/tmp/mod_rpaf-0.6.tar.gz" do
  source "http://www.linuxservices.co.uk/mod_rpaf-0.6.tar.gz"
  not_if { ::File.exists?("/tmp/mod_rpaf-0.6.tar.gz") }
end

remote_file "/tmp/mod_rpaf_xforward_for.patch" do
  source "http://www.linuxservices.co.uk/mod_rpaf_xforward_for.patch"
  not_if { ::File.exists?("/tmp/mod_rpaf_xforward_for.patch") }
end

execute "Extract mod_xsendfile source" do
  cwd "/tmp"
  command "tar -zxf /tmp/mod_rpaf-0.6.tar.gz && /tmp/mod_rpaf-0.6 && patch < /tmp/mod_rpaf_xforward_for.patch"
  not_if { ::File.exists?("/tmp/mod_rpaf-0.6") }
end

bash "Build and Install mod_rpaf" do
  cwd "/tmp/mod_rpaf-0.6"
  code "apxs -i -c -n mod_rpaf-2.0.so mod_rpaf-2.0.c"
  not_if { ::File.exists?("/usr/lib/httpd/modules/mod_rpaf-2.0.so") }
end

template "/etc/httpd/conf.d/rpaf.conf" do
  source "rpaf.conf"
  mode "0644"
end

service "apache" do
  action :restart
end

