#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Upgrade system
sudo apt update
sudo apt upgrade -y

# Update package lists
sudo deb http://packages.mendix.com/platform/debian/ buster main contrib non-free
sudo # wget -q -O - https://packages.mendix.com/mendix-debian-archive-key.asc | apt-key add -
sudo apt update

# Install required dependencies
sudo apt install -y m2ee-tools

# Install Java
wget https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.deb
sudo dpkg -i jdk-21_linux-x64_bin.deb

# Prepare user for mendix
sudo adduser --disabled-password --gecos "mendix-app" mendix

# Set up Mendix environment
sudo mkdir -p /srv/mendix/mendix-app
cd /srv/mendix/mendix-app
mkdir runtimes/ web/ model/ data/ data/database data/files data/model-upload data/tmp
sudo chown myapp:myapp * -R
sudo chmod 700 model/ data/

# Configure Mendix
# [Configuration commands]

echo "Mendix installation completed successfully!"
