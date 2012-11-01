#
# Cookbook Name:: php-fastcgi
# Recipe:: default
#

package "libjpeg-devel"
package "libpng-devel"

remote_file "/tmp/php-5.3.18.tar.bz2" do
  source "http://us1.php.net/distributions/php-5.3.18.tar.bz2"
  not_if { ::File.exists?("/tmp/php-5.3.18.tar.bz2") }
end

bash "Configuring and compiling php-fastcgi" do
  code <<-EOH
    cd /tmp/php-5.3.18
    ./configure '--prefix=/usr/local/zend' '--with-config-file-path=/usr/local/zend/etc' \
    '--with-config-file-scan-dir=/usr/local/zend/etc/conf.d' \
    '--enable-inline-optimization' '--disable-all' '--disable-debug'  \
    '--with-layout=GNU' '--enable-filter' '--with-pcre-regex' '--with-openssl' '--without-pear' \
    '--enable-libxml' '--enable-session' '--enable-xml' '--enable-hash' '--enable-filter' \
    '--with-pcre-regex' '--with-zlib' '--enable-simplexml' '--enable-dom' '--with-openssl' '--with-iconv'  \
    '--enable-pdo' '--with-pdo-sqlite' '--with-sqlite3' '--disable-phar' '--enable-xmlwriter' '--enable-xmlreader' \
    '--enable-fpm' '--with-fpm-user=apache' '--with-fpm-group=apache'
    make
    cp /tmp/php-5.3.18/sapi/fpm/php-fpm /usr/local/zend/bin/
  EOH
  not_if "test -f /usr/local/zend/bin/php-fpm"
end

bash "Install php-fpm init.d/ script" do
  code <<-EOH
    rm /etc/init.d/php-fpm
    ln -s /www/init.d/php-fpm /etc/init.d/php-fpm
    chkconfig --level 345 php-fpm on
  EOH
  not_if "test -L /etc/init.d/php-fpm"
end
