sudo cp -vr ~/mgmt/srvsalt/. /srv/salt/
sudo cp -vr ~/mgmt/etcsalt/. /etc/salt/
sudo cp -vr ~/mgmt/srvpillar/. /srv/pillar/

sudo systemctl restart salt-minion
sudo systemctl restart salt-master
