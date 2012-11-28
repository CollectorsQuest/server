# Timecards

package "perl-CPAN"
package "perl-DateTime"

bash "Checkout ~/.timecards from GitHub" do
  code <<-EOH
    git clone -q git@github.com:CollectorsQuest/timecards.git /root/.timecards
    cd /root/.timecards && git submodule update --recursive
    ln -s /root/.timecards/bin/timecard /usr/local/bin/timecard
    ln -s /root/.timecards/bin/clock /usr/local/bin/clock
    rm /sbin/clock
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
