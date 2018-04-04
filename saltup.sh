sudo cp ~/mgmt/srvsalt/. /srv/salt
sudo cp ~/mgmt/etcsalt/. /etc/salt

sudo systemctl restart salt-minion
sudo systemctl restart salt-master
