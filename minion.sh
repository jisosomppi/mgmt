# Setup computer as minion

setxkbmap fi
sudo timedatectl set-timezone Europe/Helsinki
sudo apt-get update
sudo apt-get install -y git tree htop salt-minion
cd

echo "master: 172.28.171.118" | sudo tee -a /etc/salt/minion

sudo service salt-minion restart
