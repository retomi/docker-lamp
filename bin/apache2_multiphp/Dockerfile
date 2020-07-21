FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

# install
RUN apt-get -y update
RUN apt-get -y full-upgrade
RUN apt-get -y autoremove
RUN apt-get -y install lsb-release tzdata apt-utils net-tools iproute2 netcat dnsutils curl iputils-ping iptables nmap tcpdump software-properties-common git wget vim htop zip unzip openssl nano graphicsmagick imagemagick ghostscript mysql-client iputils-ping locales sqlite3 ca-certificates sudo nodejs npm

# apache
RUN apt-get -y install apache2
RUN apt-get -y install libapache2-mod-fcgid
RUN a2enmod rewrite actions alias headers
RUN echo "ServerName localhost" | tee /etc/apache2/conf-available/servername.conf
RUN echo "Listen 8080" >> /etc/apache2/ports.conf
RUN a2enconf servername
RUN a2enmod dav dav_fs proxy_fcgi

# timezone
RUN ln -fs /usr/share/zoneinfo/Europe/Rome /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

# multiple php
RUN add-apt-repository ppa:ondrej/php && apt update

RUN apt-get install -y php5.6 php5.6-fpm libapache2-mod-php5.6 php5.6-mysql php5.6-curl php5.6-cli php5.6-json php5.6-opcache php5.6-readline php5.6-common php5.6-mysqlnd php5.6-bcmath php5.6-gd php5.6-intl php5.6-mbstring php5.6-imap php5.6-interbase php5.6-ldap php5.6-pgsql php5.6-snmp php5.6-soap php5.6-tidy php5.6-xml php5.6-xsl php5.6-zip php5.6-recode php5.6-gmp php5.6-sqlite3

RUN apt-get install -y php7.2 php7.2-fpm libapache2-mod-php7.2 php7.2-mysql php7.2-curl php7.2-cli php7.2-json php7.2-opcache php7.2-readline php7.2-common php7.2-mysqlnd php7.2-bcmath php7.2-gd php7.2-intl php7.2-mbstring php7.2-imap php7.2-interbase php7.2-ldap php7.2-pgsql php7.2-snmp php7.2-soap php7.2-tidy php7.2-xml php7.2-xsl php7.2-zip php7.2-recode php7.2-gmp php7.2-sqlite3

RUN apt-get install -y php7.4 php7.4-fpm libapache2-mod-php7.4 php7.4-mysql php7.4-curl php7.4-cli php7.4-json php7.4-opcache php7.4-readline php7.4-common php7.4-bcmath php7.4-gd php7.4-intl php7.4-mbstring php7.4-imap php7.4-interbase php7.4-ldap php7.4-pgsql php7.4-snmp php7.4-soap php7.4-tidy php7.4-xml php7.4-xsl php7.4-zip php7.4-gmp php7.4-sqlite3

# php
RUN apt-get update
RUN apt-get -y install php-uploadprogress php-mailparse php-imagick php-psr php-memcached php-xdebug
# RUN apt-get -y install php-xmlrpc
# RUN apt-get -y install php-phalcon4

# Add composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer

# Add user for application (NO MACOS)
RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www
RUN usermod -d /var/www www
COPY . /var/www
COPY --chown=www:www . /var/www
RUN echo 'alias ll="ls -la --color"' >> ~/.bashrc
#RUN chown www:www /var/www/

# clean up
RUN apt-get -y autoclean && apt-get -y autoremove
RUN apt-get -y purge $(dpkg --get-selections | grep deinstall | sed s/deinstall//g)
RUN rm -rf /var/lib/apt/lists/*

EXPOSE 80 443

ADD start.sh /
RUN chmod +x /start.sh

CMD ["/start.sh"]
