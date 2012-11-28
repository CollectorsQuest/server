include_recipe "zend"

package "autoconf"
package "autoconf213"

remote_file "/tmp/redis.tar.gz" do
  source "https://github.com/nicolasff/phpredis/tarball/2.2.1"
  not_if { ::File.exists?("/tmp/redis.tar.gz") }
end

bash "Installing redis.so" do
  cwd "/tmp"
  code <<-EOH
    tar xfz /tmp/redis.tar.gz && cd /tmp/nicolasff-phpredis-250e81b
    /usr/local/zend/bin/phpize && ./configure --with-php-config=/usr/local/zend/bin/php-config
    make && make install
  EOH
  not_if { ::File.exists?("/usr/local/zend/lib/php_extensions/redis.so") }
end

template "/usr/local/zend/etc/conf.d/redis.ini" do
  source "redis.ini"
  mode "0664"
end
