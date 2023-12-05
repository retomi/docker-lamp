FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

# install
RUN apt-get -y update \
    && apt-get -y full-upgrade \
    && apt-get -y install \
        lsb-release tzdata apt-utils net-tools iproute2 netcat dnsutils curl \
        iputils-ping iptables nmap tcpdump software-properties-common git wget \
        vim htop zip unzip openssl nano graphicsmagick imagemagick ghostscript \
        mysql-client postgresql-client iputils-ping locales sqlite3 ca-certificates sudo \
        zsh powerline fonts-powerline openssh-server gcc libpcre3-dev software-properties-common

# locale
RUN locale-gen "it_IT.UTF-8"
RUN update-locale LANG=it_IT.UTF-8

# timezone
RUN ln -fs /usr/share/zoneinfo/Europe/Rome /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

# apache
RUN add-apt-repository ppa:ondrej/apache2 -y
RUN apt-get -y update \
    && apt-get -y install apache2 \
    && apt-get -y install libapache2-mod-fcgid
RUN a2enmod rewrite actions alias headers
RUN echo "ServerName localhost" | tee /etc/apache2/conf-available/servername.conf
RUN a2enconf servername
RUN a2enmod rewrite actions alias headers dav dav_fs proxy_fcgi ssl deflate

# Add user for application
RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www
RUN usermod -aG sudo www
RUN echo "www:www" | chpasswd

RUN sed -i 's/Timeout 300/Timeout 200/g' /etc/apache2/apache2.conf
RUN sed -i 's/MaxKeepAliveRequests 100/MaxKeepAliveRequests 500/g' /etc/apache2/apache2.conf
RUN sed -i 's/KeepAliveTimeout 5/KeepAliveTimeout 3/g' /etc/apache2/apache2.conf
RUN sed -i 's/export APACHE_RUN_USER=www-data/export APACHE_RUN_USER=www/g' /etc/apache2/envvars
RUN echo 'MaxRequestWorkers 5' >> /etc/apache2/apache2.conf
RUN echo 'ThreadsPerChild 5' >> /etc/apache2/apache2.conf

# multiple php
RUN add-apt-repository ppa:ondrej/php \
    && apt update \
    && apt-get install -y php5.6 php5.6-fpm libapache2-mod-php5.6 php5.6-mysql php5.6-curl php5.6-cli php5.6-json php5.6-opcache php5.6-readline php5.6-common php5.6-mysqlnd php5.6-bcmath php5.6-gd php5.6-intl php5.6-mbstring php5.6-imap php5.6-interbase php5.6-ldap php5.6-pgsql php5.6-snmp php5.6-soap php5.6-tidy php5.6-xml php5.6-xsl php5.6-zip php5.6-recode php5.6-gmp php5.6-sqlite3 php5.6-pdo-dblib php5.6-bz2 \
    && apt-get install -y php7.2 php7.2-fpm libapache2-mod-php7.2 php7.2-mysql php7.2-curl php7.2-cli php7.2-json php7.2-opcache php7.2-readline php7.2-common php7.2-mysqlnd php7.2-bcmath php7.2-gd php7.2-intl php7.2-mbstring php7.2-imap php7.2-interbase php7.2-ldap php7.2-pgsql php7.2-snmp php7.2-soap php7.2-tidy php7.2-xml php7.2-xsl php7.2-zip php7.2-recode php7.2-gmp php7.2-sqlite3 php7.2-pdo-dblib php7.2-bz2 \
    && apt-get install -y php7.4 php7.4-fpm libapache2-mod-php7.4 php7.4-mysql php7.4-curl php7.4-cli php7.4-json php7.4-opcache php7.4-readline php7.4-common php7.4-bcmath php7.4-gd php7.4-intl php7.4-mbstring php7.4-imap php7.4-interbase php7.4-ldap php7.4-pgsql php7.4-snmp php7.4-soap php7.4-tidy php7.4-xml php7.4-xsl php7.4-zip php7.4-gmp php7.4-sqlite3 php7.4-pdo-dblib php7.4-bz2 \
    && apt-get install -y php8.0 php8.0-fpm libapache2-mod-php8.0 php8.0-mysql php8.0-curl php8.0-cli php8.0-opcache php8.0-readline php8.0-common php8.0-bcmath php8.0-gd php8.0-intl php8.0-mbstring php8.0-imap php8.0-interbase php8.0-ldap php8.0-pgsql php8.0-snmp php8.0-soap php8.0-tidy php8.0-xml php8.0-xsl php8.0-zip php8.0-gmp php8.0-sqlite3 php8.0-pdo-dblib php8.0-bz2 \
    && apt-get install -y php8.1 php8.1-fpm libapache2-mod-php8.1 php8.1-mysql php8.1-curl php8.1-cli php8.1-opcache php8.1-readline php8.1-common php8.1-bcmath php8.1-gd php8.1-intl php8.1-mbstring php8.1-imap php8.1-interbase php8.1-ldap php8.1-pgsql php8.1-snmp php8.1-soap php8.1-tidy php8.1-xml php8.1-xsl php8.1-zip php8.1-gmp php8.1-sqlite3 php8.1-pdo-dblib php8.1-bz2

# sync with production
RUN add-apt-repository ppa:ondrej/php \
    && apt update \
    && apt-get install -y php7.4 php7.4-bcmath php7.4-cli php7.4-common php7.4-fpm php7.4-gd php7.4-gmp php7.4-imagick php7.4-imap php7.4-intl php7.4-json php7.4-ldap php7.4-mbstring php7.4-mysql php7.4-mysqlnd php7.4-opcache php7.4-pdo php7.4-pgsql php7.4-smbclient php7.4-soap php7.4-sybase php7.4-tidy php7.4-xml php7.4-xmlrpc php7.4-zip php7.4-mailparse php7.4-uploadprogress php7.4-zip libapache2-mod-php7.4 php7.4-curl php7.4-readline php7.4-interbase php7.4-snmp php7.4-xsl php7.4-sqlite3 php7.4-pdo-dblib php7.4-bz2 php7.4-mcrypt php7.4-memcached php7.4-psr

# php
RUN apt-get -y update \
    && apt-get -y install php-uploadprogress php-mailparse php-imagick php-psr php-memcached

RUN a2dismod php5.6
RUN a2dismod mpm_prefork
RUN a2enmod mpm_event
RUN a2enmod http2

# python3
RUN apt-get -y install python3-pip

# ssmtp
RUN sudo apt-get -y install ssmtp

# ioncube
RUN echo "$TARGETPLATFORM"
RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
        curl -o ioncube.tar.gz https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz ; \
    else \
        curl -o ioncube.tar.gz https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_aarch64.tar.gz ; \
    fi
RUN tar -xvvzf ioncube.tar.gz \
    && mv ioncube/ioncube_loader_lin_7.4.so /usr/lib/php/20190902/ \
    && rm -Rf ioncube.tar.gz ioncube
RUN chown "root:root" /usr/lib/php/20190902/ioncube_loader_lin_7.4.so

# Nodejs
RUN apt-get -y update \
    && apt-get install -y ca-certificates curl gnupg \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && NODE_MAJOR=20 \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
    && apt-get -y update && apt-get install nodejs -y && npm install --global bower gulp-cli

# Add composer
RUN update-alternatives --set php /usr/bin/php7.4
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer

# clean up
RUN apt-get -y autoclean && apt-get -y autoremove
RUN apt-get -y purge $(dpkg --get-selections | grep deinstall | sed s/deinstall//g)
RUN rm -rf /var/lib/apt/lists/*

EXPOSE 22 80 443

ADD start.sh /
RUN chmod +x /start.sh
CMD ["/start.sh"]
