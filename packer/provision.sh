#!/bin/bash
set -e
#provision.sh sudo apt-get update
echo "apt-get update done."
sudo apt-get clean
sudo apt-get update
sudo apt-get install -y curl
sudo curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt-get clean
sudo apt-get update
sudo apt -y install nginx
sudo apt-get clean
sudo apt-get update
sudo apt -y install git
sudo rm /etc/nginx/sites-enabled/default 
git clone https://github.com/canzig21/groundhogapp.git
sudo mv groundhogapp/groundhogapp /var/
cd /var/groundhogapp
sudo npm install
sudo npm install pm2@latest -g
sudo pm2 start bin/www
sudo pm2 startup systemd
sudo pm2 save
sudo cp /var/groundhogapp/nginx_conf.conf /etc/nginx/conf.d/nginx_conf.conf
sudo nginx -s reload
sudo mkdir --parents /etc/consul.d
sudo mkdir /opt/consul
wget https://groundhog-hc-canzig-appcode.s3.amazonaws.com/consul_client_config.json
sudo mv consul_client_config.json /etc/consul.d/
#sudo timedatectl set-timezone Europe/Istanbul
sudo localectl set-locale LANG=en_US.utf8
git clone --branch v0.7.3 https://github.com/hashicorp/terraform-aws-consul.git
terraform-aws-consul/modules/install-consul/install-consul --version 0.7.3
sudo chown --recursive consul:consul /etc/consul.d
terraform-aws-consul/modules/install-dnsmasq/install-dnsmasq
sudo /etc/init.d/dnsmasq restart
echo "Running build."