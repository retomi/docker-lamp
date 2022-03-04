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
        mysql-client iputils-ping locales sqlite3 ca-certificates sudo openssh-server \
        zsh powerline fonts-powerline openssh-server

# locale
RUN locale-gen "it_IT.UTF-8"
RUN update-locale LANG=it_IT.UTF-8

# apache
RUN apt-get -y update \
    && apt-get -y install apache2 \
    && apt-get -y install libapache2-mod-fcgid
RUN a2enmod rewrite actions alias headers
RUN echo "ServerName localhost" | tee /etc/apache2/conf-available/servername.conf
RUN echo "Listen 8080" >> /etc/apache2/ports.conf
RUN a2enconf servername
RUN a2enmod dav dav_fs proxy_fcgi

# timezone
RUN ln -fs /usr/share/zoneinfo/Europe/Rome /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

# multiple php
RUN add-apt-repository ppa:ondrej/php \
    && apt update \
    && apt-get install -y php5.6 php5.6-fpm libapache2-mod-php5.6 php5.6-mysql php5.6-curl php5.6-cli php5.6-json php5.6-opcache php5.6-readline php5.6-common php5.6-mysqlnd php5.6-bcmath php5.6-gd php5.6-intl php5.6-mbstring php5.6-imap php5.6-interbase php5.6-ldap php5.6-pgsql php5.6-snmp php5.6-soap php5.6-tidy php5.6-xml php5.6-xsl php5.6-zip php5.6-recode php5.6-gmp php5.6-sqlite3 php5.6-pdo-dblib php5.6-bz2 \
    && apt-get install -y php7.2 php7.2-fpm libapache2-mod-php7.2 php7.2-mysql php7.2-curl php7.2-cli php7.2-json php7.2-opcache php7.2-readline php7.2-common php7.2-mysqlnd php7.2-bcmath php7.2-gd php7.2-intl php7.2-mbstring php7.2-imap php7.2-interbase php7.2-ldap php7.2-pgsql php7.2-snmp php7.2-soap php7.2-tidy php7.2-xml php7.2-xsl php7.2-zip php7.2-recode php7.2-gmp php7.2-sqlite3 php7.2-pdo-dblib php7.2-bz2 \
    && apt-get install -y php7.4 php7.4-fpm libapache2-mod-php7.4 php7.4-mysql php7.4-curl php7.4-cli php7.4-json php7.4-opcache php7.4-readline php7.4-common php7.4-bcmath php7.4-gd php7.4-intl php7.4-mbstring php7.4-imap php7.4-interbase php7.4-ldap php7.4-pgsql php7.4-snmp php7.4-soap php7.4-tidy php7.4-xml php7.4-xsl php7.4-zip php7.4-gmp php7.4-sqlite3 php7.4-pdo-dblib php7.2-bz2 \
    && apt-get install -y php8.0 php8.0-fpm libapache2-mod-php8.0 php8.0-mysql php8.0-curl php8.0-cli php8.0-opcache php8.0-readline php8.0-common php8.0-bcmath php8.0-gd php8.0-intl php8.0-mbstring php8.0-imap php8.0-interbase php8.0-ldap php8.0-pgsql php8.0-snmp php8.0-soap php8.0-tidy php8.0-xml php8.0-xsl php8.0-zip php8.0-gmp php8.0-sqlite3 php8.0-pdo-dblib php8.0-bz2

# php
RUN apt-get -y update \
    && apt-get -y install php-uploadprogress php-mailparse php-imagick php-psr php-memcached
# RUN apt-get -y install php-xdebug
# RUN apt-get -y install php-xmlrpc

RUN sudo apt-get -y install gcc libpcre3-dev software-properties-common

#RUN curl -s "https://packagecloud.io/install/repositories/phalcon/stable/script.deb.sh" | sudo bash
#RUN apt-get -y install php7.4-phalcon
#RUN a2enmod proxy_fcgi setenvif
#RUN a2enconf php7.4-fpm

# Add user for application (NO MACOS)
RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www
RUN usermod -aG sudo www
RUN echo "www:www" | chpasswd
RUN chown -R "www:www" /var/www/html

RUN sed -i 's/user = www-data/user = www/g' /etc/php/5.6/fpm/pool.d/www.conf \
    && sed -i 's/user = www-data/user = www/g' /etc/php/7.2/fpm/pool.d/www.conf \
    && sed -i 's/user = www-data/user = www/g' /etc/php/7.4/fpm/pool.d/www.conf \
    && sed -i 's/user = www-data/user = www/g' /etc/php/8.0/fpm/pool.d/www.conf \
    && sed -i 's/;catch_workers_output = yes/catch_workers_output = yes/g' /etc/php/5.6/fpm/pool.d/www.conf \
    && sed -i 's/;catch_workers_output = yes/catch_workers_output = yes/g' /etc/php/7.2/fpm/pool.d/www.conf \
    && sed -i 's/;catch_workers_output = yes/catch_workers_output = yes/g' /etc/php/7.4/fpm/pool.d/www.conf \
    && sed -i 's/;catch_workers_output = yes/catch_workers_output = yes/g' /etc/php/8.0/fpm/pool.d/www.conf

RUN apt-get -y update \
    && curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash - \
    && sudo apt-get install -y nodejs \
    && npm install --global bower gulp-cli

# Add composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer

RUN mkdir /history && chmod -R 777 /history
RUN touch /history/.root_history && ln -s /history/.root_history /root/.bash_history

USER www

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
RUN git config --global oh-my-zsh.hide-dirty 1

RUN touch /history/.www_history && ln -s /history/.www_history /home/www/.bash_history
RUN touch /history/.zsh_history && ln -s /history/.zsh_history /home/www/.zsh_history


# clean up
USER root
RUN apt-get -y autoclean && apt-get -y autoremove
RUN apt-get -y purge $(dpkg --get-selections | grep deinstall | sed s/deinstall//g)
RUN rm -rf /var/lib/apt/lists/*

EXPOSE 22 80 443

ADD start.sh /
RUN chmod +x /start.sh

CMD ["/start.sh"]
