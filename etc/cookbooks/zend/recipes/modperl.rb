package "mod_perl"
package "perl-CPAN"

execute "Install Digest::HMAC_SHA1" do
  command "export PERL_MM_USE_DEFAULT=1 && /usr/bin/cpan Digest::HMAC_SHA1"
end

execute "Install Digest::SHA1" do
  command "export PERL_MM_USE_DEFAULT=1 && /usr/bin/cpan Digest::SHA1"
end
