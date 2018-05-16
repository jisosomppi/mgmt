# Setup computer as minion

setxkbmap fi
sudo timedatectl set-timezone Europe/Helsinki
sudo apt-get update
sudo apt-get install -y git tree htop salt-minion
cd

# Add salt-master and set ID
echo -e "\nmaster: 172.28.171.118\nid: fileserver" | sudo tee -a /etc/salt/minion
sudo service salt-minion restart
