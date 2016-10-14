#!/bin/bash

sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
sudo bash -c 'echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" >>  /etc/apt/sources.list'
apt-cache policy docker-engine
sudo apt-get install -y linux-image-extra-$(uname -r) linux-image-extra-virtual
sudo apt-get update

sudo apt-get install -y docker-engine
sudo service docker start
sudo groupadd docker
sudo usermod -aG docker $USER
sudo systemctl enable docker

sudo perl -pi -e 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"/' /etc/default/grub

echo "Installing Rancher, remember to open port 8080 on EC2 !!!!!"
sudo docker run -d --restart=unless-stopped -p 8080:8080 rancher/server
echo "DONT FORGET TO OPEN PORT 8080 !!!!!!"

echo "Now do a reboot"
