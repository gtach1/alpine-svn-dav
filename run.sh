#!/bin/sh

[[ -n "$SVN_REPO" ]] &&
{
  test ! -d "/var/svn/$SVN_REPO" && svnadmin create /svn/$SVN_REPO && chgrp -R apache /var/svn/$SVN_REPO && chmod -R 775 /var/svn/$SVN_REPO
}

test ! -d "/var/svn/template" && mkdir -p /var/svn/template/trunk && mkdir /var/svn/template/tags && mkdir /var/svn/template/branches

[[ -n "$SVN_USER"   &&  -n "$SVN_PASS" ]] && htpasswd -bc /etc/apache2/conf.d/davsvn.htpasswd $SVN_USER $SVN_PASS

[[ -z "$SVN_HTML" ]] ||
{
  rm -f /var/www/localhost/htdocs/index.html
  cp /var/svn/$SVN_HTML/index.html /var/www/localhost/htdocs/index.html
}

httpd -D FOREGROUND
