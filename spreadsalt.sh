sudo cp -avr ~/mgmt/srvsalt/. /srv/salt/
sudo cp -avr ~/mgmt/etcsalt/. /etc/salt/

sudo systemctl restart salt-minion
sudo systemctl restart salt-master
