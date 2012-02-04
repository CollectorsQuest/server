package GodAuthConfig;

our $LogFile            = '/www/logs/auth.log';
our $CookieName         = 'ga';
our $CookieSecret       = 's6nr1ea16fo1br0wn5a31wnzhhazerr8';
our $FailCookieOld      = 'http://backend.collectorsquest.com/ga?fail=old';
our $FailCookieFuture   = 'http://backend.collectorsquest.com/ga?fail=future';
our $FailCookieInvalid  = 'http://backend.collectorsquest.com/ga?fail=invalid';
our $FailNotOnList      = 'http://backend.collectorsquest.com/ga?fail=notonlist';
our $FailNeedsAuth      = 'http://backend.collectorsquest.com/ga';
our $FailConfig         = 'http://backend.collectorsquest.com/ga?fail=unknownconfig';

##
# The first matching rule is used, so put sub-folders before the root!
##

our $PermMap = [
  {
    url     => qr!^(backend|www)\.collectorsquest\.(com|dev)/!,
    who     => 'all',
  },
  {
    url     => qr!^(backend|www)\.collectorsquest\.stg/!,
    who     => 'role:staff',
  },
  {
    url     => qr!^deploy\.collectorsquest\.(com|dev)/!,
    who     => ['role:developer', 'kangov'],
  },
];
