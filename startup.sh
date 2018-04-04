setxkbmap fi
sudo apt-get update
sudo apt-get install -y git tree htop salt-minion salt-master

cd

git clone https://github.com/jisosomppi/mgmt

git config --global user.name "Jussi Isosomppi"
git config --global user.email "jussi.isosomppi@gmail.com"
git config --global credential.helper "cache --timeout=3600"
git config --global push.default simple

sudo cp mgmt/gitup /usr/local/bin/
sudo chmod 755 /usr/local/bin/gitup
