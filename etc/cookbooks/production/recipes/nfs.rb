package "nfs-utils"
package "rpcbind"

bash "Mount NFS Shares" do
  code <<-EOH
    mount -t nfs 10.195.183.239:/www/vhosts/collectorsquest.com/shared/uploads /www/vhosts/collectorsquest.com/shared/uploads
    # mount -t nfs 10.195.183.239:/www/vhosts/collectorsquest.com/shared/secure /www/vhosts/collectorsquest.com/shared/secure
  EOH
end
