include_recipe "zend"

package "GeoIP"
package "GeoIP-devel"

execute "Install GeoIP PHP module" do
  command "/usr/local/zend/bin/pecl install channel://pecl.php.net/geoip"
  not_if "test -e /usr/local/zend/lib/php_extensions/geoip.so"
end

template "/usr/local/zend/etc/conf.d/geoip.ini" do
  source "geoip.ini"
  mode "0664"
end
