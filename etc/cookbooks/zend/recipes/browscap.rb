include_recipe "zend"

template "/usr/local/zend/etc/conf.d/browscap.ini" do
  source "browscap.ini"
  mode "0664"
end

template "/usr/local/zend/etc/conf.d/lite_php_browscap.txt" do
  source "lite_php_browscap.txt"
  mode "0664"
end
