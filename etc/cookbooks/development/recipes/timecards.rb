# Timecards

package "perl-CPAN"

bash "Install timecard dependencies" do
  code <<-EOH
    curl -L http://cpanmin.us | perl - --sudo App::cpanminus
    cpanm DateTime
  EOH
  not_if "test -f /usr/local/lib/perl5/DateTime.pm"
end

bash "Checkout ~/.timecards from GitHub" do
  code <<-EOH
    git clone -q git@github.com:CollectorsQuest/timecards.git /root/.timecards
    cd /root/.timecards && git submodule update --recursive
  EOH
  not_if "test -d /root/.timecards"
end

bash "Updating ~/.timecards from GitHub" do
  code <<-EOH
    cd /root/.timecards
    git pull --ff origin master
    git submodule update --recursive
  EOH
end
