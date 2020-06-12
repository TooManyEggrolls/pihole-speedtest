#!/bin/bash

echo "Installing Speedtest-mod and required dependencies"

command -v pihole >/dev/null 2>&1 || { whiptail --title "Install Failed" --msgbox  "No pihole install found. Aborting install"  8 78 >&2; exit;}

if php -v | grep 'PHP 7' > /dev/null ; then

	sudo apt install php7.3-sqlite -y

else

	sudo apt install php5-sqlite -y

fi

sudo apt install python-pip -y &> /dev/null

sudo pip install speedtest-cli &> /dev/null

sudo apt install sqlite3 -y &> /dev/null

sudo apt install -y jq &> /dev/null

cd /var/www/html

sudo mv admin pihole_admin

sudo git clone https://github.com/TooManyEggrolls/AdminLTE admin

cd admin

if [ ! -f /etc/pihole/speedtest.db ]; then
	#Create new DB in /etc/pihole/
	sudo cp scripts/pi-hole/speedtest/speedtest.db /etc/pihole/
fi

cd /opt/pihole/
sudo mv webpage.sh webpage.sh.org
sudo wget https://github.com/TooManyEggrolls/pi-hole/raw/master/advanced/Scripts/webpage.sh
