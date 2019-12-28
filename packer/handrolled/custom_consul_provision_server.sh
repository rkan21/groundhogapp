#!/bin/bash
set -e
wget https://releases.hashicorp.com/consul/1.6.2/consul_1.6.2_linux_amd64.zip
sudo apt-get update
sudo apt-get install unzip -y
unzip consul_1.6.2_linux_amd64.zip
sudo chown root:root consul
sudo mv consul /usr/local/bin/
consul -autocomplete-install
complete -C /usr/local/bin/consul consul
sudo mkdir --parents /opt/consul
sudo useradd --system --home /etc/consul.d --shell /bin/false consul
sudo chown --recursive consul:consul /opt/consul
sudo chown consul:consul /usr/local/bin/consul
wget https://groundhog-hc-canzig-appcode.s3.amazonaws.com/consul_client/consul.service
sudo mv consul.service /etc/systemd/system/
sudo mkdir --parents /etc/consul.d
#sudo touch /etc/consul.d/consul.hcl
wget https://groundhog-hc-canzig-appcode.s3.amazonaws.com/consul_client/consul_client_config.json
sudo mv consul_client_config.json /etc/consul.d/
sudo chown --recursive consul:consul /etc/consul.d
sudo chmod 640 /etc/consul.d/consul_client_config.json
sudo systemctl enable consul
#sudo consul agent -join 10.20.20.21 -data-dir /opt/consul -config-dir /etc/consul.d &
