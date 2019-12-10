#!/bin/sh
set -ex
export LC_ALL=C

VER=${DOCKER_LAM_VER:-6.6}
LAM_PKG=ldap-account-manager-${VER}.tar.bz2
LAM_URL=http://prdownloads.sourceforge.net/lam/${LAM_PKG}?download
LAM_DIR=${DOCKER_LAM_DIR:-"/wwwroot/lam"}
LAM_PKG_DIR="/wwwroot"

PHP_INI_DIR=$(php --ini | grep "php.ini" | grep -oE "/.*")
PHP_CONF_DIR=$(php --ini | grep additional | grep -o "/.*/etc/php.*")
FPM_CONF_DIR="/usr/local/etc/php-fpm.d"

config_php() {
    cp ${PHP_INI_DIR}/php.ini-production ${PHP_INI_DIR}/php.ini

    #config php session
    local php_cfg=${PHP_CONF_DIR}/extra.ini
    local PHP_SESSION_DIR=${LAM_DIR}/tmp/session
cat > ${php_cfg} << EOF
session.save_handler = "files"
session.save_path    = "${PHP_SESSION_DIR}"
expose_php = false
cgi.fix_pathinfo = 0
date.timezone = Asia/Shanghai
short_open_tag = On
upload_max_filesize = 50M
disable_functions = passthru,exec,system,chroot,chgrp,chown,shell_exec,proc_open,proc_get_status,ini_alter,ini_restore,dl,openlog,syslog,readlink,symlink,popepassthru,stream_socket_server,fsocket,popen
EOF
    #run php-fpm as deamon
    # local php_fpm_docker_cfg=${FPM_CONF_DIR}/zz-docker.conf
    # sed -i "s#^daemonize = .*#daemonize = yes#g" $php_fpm_docker_cfg
    # sed -i "s#listen = .*#listen = /dev/shm/php-cgi.sock#g" $php_fpm_docker_cfg

    local php_fpm_www_cfg=${FPM_CONF_DIR}/www.conf
    sed -i "s#^pm.max_children =.*#pm.max_children = 50#g" $php_fpm_www_cfg
    sed -i "s#^pm.start_servers =.*# pm.start_servers = 30#g" $php_fpm_www_cfg
    sed -i "s#^pm.min_spare_servers = .*#pm.min_spare_servers = 20#g" $php_fpm_www_cfg
    sed -i "s#^pm.max_spare_servers = .*#pm.max_spare_servers = 50#g" $php_fpm_www_cfg
    sed -i "s#^;pm.max_requests = .*#pm.max_requests = 2048#g" $php_fpm_www_cfg
}

init_deps() {
    #apt-get install -yqq locales tzdata
    #locale-gen zh_CN.UTF-8
    sed -i 's@dl-cdn.alpinelinux.org@mirrors.aliyun.com@g' /etc/apk/repositories
    apk add --no-cache --virtual .fetch-deps \
            openldap-dev zlib-dev libzip-dev \
            gettext-dev perl libzip make
    apk add --no-cache --virtual .build-deps \
            coreutils
    export PHP_EXT="gettext zip ldap"
	docker-php-ext-install -j$(nproc) ${PHP_EXT}
}

clean() {
    apk del .build-deps
    rm -rf /tmp/* /var/tmp/*
}

download_extract_lam() {
    local lam=/tmp/${LAM_PKG}
    curl -L ${LAM_URL} -o $lam
    tar xf $lam -C ${LAM_PKG_DIR}
}

install_lam() {
    if [ -f "${LAM_DIR}/VERSION" ];then
        exit 0
    fi

    [ -d ${LAM_DIR} ] || install -d ${LAM_DIR}
    local LAM=${LAM_PKG_DIR}/${LAM_PKG%.tar.bz2}
    cd ${LAM}
    ./configure \
        --with-httpd-user=www-data \
        --with-httpd-group=root \
        --with-web-root=${LAM_DIR} \
        --localstatedir=${LAM_DIR}/var \
        --sysconfdir=${LAM_DIR}/etc
    make install
    cd -

    # cd ${LAM_DIR}/config
    # cp config.cfg.sample config.cfg
    # cp unix.conf.sample lam.conf
    # cd -
}

init_deps
config_php
download_extract_lam
clean
