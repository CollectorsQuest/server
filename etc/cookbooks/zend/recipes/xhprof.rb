include_recipe "zend"

package "graphviz"
package "autoconf"
package "autoconf213"

remote_file "/tmp/xhprof.tar.gz" do
  source "https://github.com/preinheimer/xhprof/archive/58ceef1a59e89eb44a932e767d04e2340521cd77.tar.gz"
  not_if { ::File.exists?("/tmp/xhprof.tar.gz") }
end

bash "Installing xhprof.so" do
  cwd "/tmp"
  code <<-EOH
    tar xfz /tmp/xhprof.tar.gz && cd /tmp/xhprof-58ceef1a59e89eb44a932e767d04e2340521cd77/extension
    /usr/local/zend/bin/phpize && ./configure --with-php-config=/usr/local/zend/bin/php-config
    make && make install
  EOH
  not_if { ::File.exists?("/usr/local/zend/lib/php_extensions/xhprof.so") }
end

template "/usr/local/zend/etc/conf.d/xhprof.ini" do
  source "xhprof.ini"
  mode "0664"
end
