# PHP-FPM
#
# Version 0.0.1

FROM centos:7

ENTRYPOINT "php-fpm"

EXPOSE 9000

RUN /bin/localedef -v -c -i en_US -f UTF-8 en_US.UTF-8;\
    yum -y install epel-release; \
    yum -y install php-gd php-fpm php-mysql php-xml php-soap php-snmp php-pgsql php-odbc php-bcmath php-cli php-common php-enchant php-intl php-mbstring php-pear php-pecl-memcache php-pspell php-recode php-xmlrpc supervisor;\
    yum clean all;\
    curl -L https://github.com/kelseyhightower/confd/releases/download/v0.10.0/confd-0.10.0-linux-amd64 -o /usr/bin/confd;\
    chmod +x /usr/bin/confd;\
    sed -i '/^upload_max_filesize/cupload_max_filesize\ \=\ 64M' /etc/php.ini;\
    sed -i '/^post_max_size/cpost_max_size\ \=\ 64M' /etc/php.ini;\
    sed -i '/^listen = /clisten = 0.0.0.0:9000' /etc/php-fpm.d/www.conf;\
    sed -i '/^listen.allowed_clients/c;listen.allowed_clients =' /etc/php-fpm.d/www.conf;\
    sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php-fpm.conf;\
    sed -i '/^error_log = /cerror_log = /proc/self/fd/2' /etc/php-fpm.conf
