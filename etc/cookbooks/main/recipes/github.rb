package "git"

bash "Install the RSA identity" do
  code <<-EOH
    mkdir -p ~/.ssh/ && chmod 600 ~/.ssh/
    echo "github.com,207.97.227.239 ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==" > ~/.ssh/known_hosts
    cp /vagrant/id_rsa ~/.ssh/id_rsa && chmod 600 ~/.ssh/id_rsa
    exec /usr/bin/ssh-agent bash
    ssh-add ~/.ssh/id_rsa
  EOH
end

bash "Checkout /www from GitHub" do
  code <<-EOH
    git clone git@github.com:CollectorsQuest/server.git /www
    cd /www && git submodule update --init --recursive
  EOH
  not_if "test -d /www"
end

bash "Checkout /www from GitHub" do
  code <<-EOH
    cd /www
    git pull --ff origin master
    git submodule update --recursive
  EOH
end
