#!/bin/bash
su - www -c 'composer global require laravel/installer'
su - www -c 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended'
su - www -c "git clone https://github.com/zsh-users/zsh-autosuggestions /home/www/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
su - www -c "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /home/www/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
su - www -c 'git config --global oh-my-zsh.hide-dirty 1'

sudo -H sh -c "git clone https://github.com/zsh-users/zsh-autosuggestions /home/www/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
sudo -H sh -c "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /home/www/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
/usr/sbin/service ssh start
/usr/sbin/service php5.6-fpm start
/usr/sbin/service php7.2-fpm start
/usr/sbin/service php7.4-fpm start
/usr/sbin/service php8.0-fpm start
/usr/sbin/service php8.1-fpm start
/usr/sbin/service apache2 start
/usr/sbin/apache2ctl restart
sudo sed -i 's/www:x:1000:1000::\/home\/www:\/bin\/bash/www:x:1000:1000::\/home\/www:\/bin\/zsh/g' /etc/passwd
chown -R "www:www" /var/www
tail -f /dev/null