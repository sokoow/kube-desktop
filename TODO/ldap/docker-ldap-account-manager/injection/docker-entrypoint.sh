#!/bin/sh

if [ "$1" = 'ldap-account-manager' ]; then
  set -e

  ##############################################################################
  # Default
  ##############################################################################

  if [ -z "${PHP_FPM_UID}" ]; then
    PHP_FPM_UID=1000
  fi
  if [ -z "${PHP_FPM_GID}" ]; then
    PHP_FPM_GID=1000
  fi

  ##############################################################################
  # Check
  ##############################################################################

  if echo -n "${PHP_FPM_UID}" | grep -Eqsv '^[0-9]+$'; then
    echo 'Please numric value: PHP_FPM_UID'
    exit 1
  fi
  if [ "${PHP_FPM_UID}" -le 0 ]; then
    echo 'Please 0 or more: PHP_FPM_UID'
    exit 1
  fi
  if [ "${PHP_FPM_UID}" -ge 60000 ]; then
    echo 'Please 60000 or less: PHP_FPM_UID'
    exit 1
  fi

  if echo -n "${PHP_FPM_GID}" | grep -Eqsv '^[0-9]+$'; then
    echo 'Please numric value: PHP_FPM_GID'
    exit 1
  fi
  if [ "${PHP_FPM_GID}" -le 0 ]; then
    echo 'Please 0 or more: PHP_FPM_GID'
    exit 1
  fi
  if [ "${PHP_FPM_GID}" -ge 60000 ]; then
    echo 'Please 60000 or less: PHP_FPM_GID'
    exit 1
  fi

  ##############################################################################
  # Clear
  ##############################################################################

  if getent passwd | awk -F ':' -- '{print $1}' | grep -Eqs '^php-fpm$'; then
    deluser 'php-fpm'
  fi
  if getent passwd | awk -F ':' -- '{print $3}' | grep -Eqs "^${PHP_FPM_UID}$"; then
    deluser "${PHP_FPM_UID}"
  fi
  if getent group | awk -F ':' -- '{print $1}' | grep -Eqs '^php-fpm$'; then
    delgroup 'php-fpm'
  fi
  if getent group | awk -F ':' -- '{print $3}' | grep -Eqs "^${PHP_FPM_GID}$"; then
    delgroup "${PHP_FPM_GID}"
  fi

  ##############################################################################
  # Group
  ##############################################################################

  addgroup -g "${PHP_FPM_GID}" 'php-fpm'

  ##############################################################################
  # User
  ##############################################################################

  adduser -h '/nonexistent' \
          -g 'php-fpm,,,' \
          -s '/usr/sbin/nologin' \
          -G 'php-fpm' \
          -D \
          -H \
          -u "${PHP_FPM_UID}" \
          'php-fpm'

  ##############################################################################
  # Initialize
  ##############################################################################

  mkdir -p /run/nginx
  mkdir -p /run/php-fpm

  ##############################################################################
  # Config
  ##############################################################################

  if [ -f "/usr/local/etc/nginx.conf.tmpl" ]; then
    dockerize -template /usr/local/etc/nginx.conf.tmpl:/etc/nginx/nginx.conf
  else
    echo "Require nginx.conf.tmpl"
    exit 1
  fi

  if [ -f "/usr/local/etc/php-fpm.conf.tmpl" ]; then
    dockerize -template /usr/local/etc/php-fpm.conf.tmpl:/etc/php7/php-fpm.conf
  else
    echo "Require php-fpm.conf.tmpl"
    exit 1
  fi

  if [ -f "/usr/local/etc/config.cfg.tmpl" ]; then
    dockerize -template /usr/local/etc/config.cfg.tmpl:/usr/local/lam/config/config.cfg
  else
    echo "Require config.cfg.tmpl"
    exit 1
  fi

  sed -i -e 's@^;date.timezone.*@date.timezone = Asia/Tokyo@;' /etc/php7/php.ini
  sed -i -e 's@^;mbstring.language.*@mbstring.language = Japanese@;' /etc/php7/php.ini
  sed -i -e 's@^;mbstring.internal_encoding.*@mbstring.internal_encoding = UTF-8@;' /etc/php7/php.ini

  ##############################################################################
  # Permission
  ##############################################################################

  chown -R nginx:nginx /run/nginx
  chown -R php-fpm:php-fpm /usr/local/lam
  chown -R php-fpm:php-fpm /run/php-fpm

  ##############################################################################
  # Check
  ##############################################################################

  ##############################################################################
  # Daemon
  ##############################################################################

  mkdir -p /etc/sv/nginx
  echo '#!/bin/sh'                   >  /etc/sv/nginx/run
  echo 'set -e'                      >> /etc/sv/nginx/run
  echo 'exec 2>&1'                   >> /etc/sv/nginx/run
  echo 'exec nginx -g "daemon off;"' >> /etc/sv/nginx/run
  chmod 0755 /etc/sv/nginx/run

  mkdir -p /etc/sv/php-fpm
  echo '#!/bin/sh'              >  /etc/sv/php-fpm/run
  echo 'set -e'                 >> /etc/sv/php-fpm/run
  echo 'exec 2>&1'              >> /etc/sv/php-fpm/run
  echo 'exec php-fpm7 -F -O -R' >> /etc/sv/php-fpm/run
  chmod 0755 /etc/sv/php-fpm/run

  ##############################################################################
  # Service
  ##############################################################################

  ln -s /etc/sv/nginx /etc/service/nginx
  ln -s /etc/sv/php-fpm /etc/service/php-fpm

  ##############################################################################
  # Running
  ##############################################################################

  echo 'Starting Server'
  exec runsvdir /etc/service
fi

exec "$@"
