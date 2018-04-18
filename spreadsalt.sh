sudo cp -avr ~/mgmt/srvsalt/. /srv/salt/
sudo cp -avr ~/mgmt/etcsalt/. /etc/salt/
sudo cp -avr ~/mgmt/srvpillar/. /srv/pillar/

sudo systemctl restart salt-minion
sudo systemctl restart salt-master
