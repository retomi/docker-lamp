#!/bin/bash
sudo echo "host    all             all              0.0.0.0/0                       md5" >> /var/lib/postgresql/data/pg_hba.conf
sudo echo "host    all             all              ::/0                            md5" >> /var/lib/postgresql/data/pg_hba.conf