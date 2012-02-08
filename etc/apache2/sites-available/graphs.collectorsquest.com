# This needs to be in your server's config somewhere, probably
# the main httpd.conf
NameVirtualHost *:80

# You may need to manually edit this file to fit your needs.
# This configuration assumes the default installation prefix
# of /opt/graphite/, if you installed graphite somewhere else
# you will need to change all the occurances of /opt/graphite/
# in this file to your chosen install location.

<VirtualHost *:80>
    ServerName graphs.collectorsquest.com
    DocumentRoot "/usr/share/graphite-web/webapp"

    ErrorLog /dev/null
    CustomLog /dev/null combined

    ServerSignature Off

    # I've found that an equal number of processes & threads tends
    # to show the best performance for Graphite (ymmv).
    WSGIDaemonProcess apache processes=5 threads=5 display-name='%{GROUP}' inactivity-timeout=120
    WSGIProcessGroup apache

    # XXX You will need to create this file! There is a graphite.wsgi.example
    # file in this directory that you can safely use, just copy it to graphite.wgsi
    WSGIScriptAlias / /etc/graphite/graphite.wsgi 

    Alias /content/ /usr/share/graphite-web/webapp/content/
    <Location "/content/">
        SetHandler None
    </Location>

    # XXX In order for the django admin site media to work you
    # must change @DJANGO_ROOT@ to be the path to your django
    # installation, which is probably something like:
    # /usr/lib/python2.6/site-packages/django
    Alias /media/ "/usr/lib/python2.6/site-packages/django/contrib/admin/media/"
    <Location "/media/">
        SetHandler None
    </Location>

    # The graphite.wsgi file has to be accessible by apache. It won't
    # be visible to clients because of the DocumentRoot though.
    <Directory /etc/graphite/>
        Order deny,allow
        Allow from all
    </Directory>

</VirtualHost>
