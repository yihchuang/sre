#!/bin/sh
echo "Installation Started"

sudo apt-get update -y
sudo apt install default-jre -y
sudo apt install openjdk-11-jre-headless -y
sudo apt install openjdk-8-jre-headless -y
sudo apt install unzip -y

# antivirus
sudo apt install make -y
wget http://sophoslinux.microsoft.com/SophosUpdate/savinstpkg.tgz && sudo tar -zxvf savinstpkg.tgz -C /opt 
sudo /opt/sophos-av/install.sh

# create a placeholder directory
mkdir /test123

echo "Installation Completed"
