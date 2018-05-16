# Setup computer as minion

setxkbmap fi
sudo timedatectl set-timezone Europe/Helsinki
sudo apt-get update
sudo apt-get install -y git tree htop salt-minion
cd

sudo service salt-minion stop
sudo rm /etc/salt/minion
echo "master: ip_address_here\nid: fs-1" | sudo tee /etc/salt/minion
sudo service salt-minion start
