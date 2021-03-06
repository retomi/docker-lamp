#!/bin/bash
/usr/sbin/service ssh start
/usr/sbin/service php5.6-fpm start
/usr/sbin/service php7.2-fpm start
/usr/sbin/service php7.4-fpm start
/usr/sbin/service php8.0-fpm start
/usr/sbin/service apache2 start
sudo -H sh -c "git config --global credential.helper store;
cat > /root/.git-credentials <<EOF
http://USER:PASSWORD@gitlab.XXX.XXX
https://USER:PASSWORD@gitlab.XXX.XXX
EOF
"
sudo sed -i 's/www:x:1000:1000::\/home\/www:\/bin\/bash/www:x:1000:1000::\/home\/www:\/bin\/zsh/g' /etc/passwd
tail -f /dev/null
