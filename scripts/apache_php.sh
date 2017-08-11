#!/bin/bash

#Update packages and Upgrade system
echo "Updating System"
sudo apt-get update && sudo apt-get upgrade

echo "Installing Apache2"
sudo apt-get -y install apache2

#Finding Public IP of Server
PUB_IP="$(ip addr show eth0 | grep inet | awk '{ print $2; }' | sed 's/\/.*$//')"

#Editing apache2.conf file
echo "ServerName $PUB_IP" >> /etc/apache2/apache2.conf

#Installing PHP and required modules
echo "Installing php modules"
apt-get -y install php libapache2-mod-php php-mcrypt php-mysql php56-mysqlnd

#Setting permissions and ownership for /var/www
echo "Setting ownership on /var/www"
sudo chown -R www-data:www-data /var/www