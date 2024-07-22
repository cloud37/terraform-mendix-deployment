#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to log messages
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if script is run as root
if [[ $EUID -ne 0 ]]; then
   log "This script must be run as root"
   exit 1
fi

# Upgrade system
log "Updating and upgrading system..."
apt update
DEBIAN_FRONTEND=noninteractive apt upgrade -y

# Add Mendix repository
log "Adding Mendix repository..."
echo "deb http://packages.mendix.com/platform/debian/ buster main contrib non-free" > /etc/apt/sources.list.d/mendix.list
if ! command_exists wget; then
    apt install -y wget
fi
wget -q -O - https://packages.mendix.com/mendix-debian-archive-key.asc | apt-key add -
apt update

# Install required dependencies
log "Installing m2ee-tools..."
apt install -y m2ee-tools

# Install Java
log "Installing Java..."
if ! command_exists java; then
    wget -q https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.deb
    dpkg -i jdk-21_linux-x64_bin.deb
    rm jdk-21_linux-x64_bin.deb
else
    log "Java is already installed, skipping..."
fi

# Prepare user for mendix
log "Creating mendix user..."
adduser --disabled-password --gecos "mendix-app" mendix

# Set up Mendix environment
log "Setting up Mendix environment..."
mkdir -p /srv/mendix/mendix-app
cd /srv/mendix/mendix-app
mkdir -p runtimes/ web/ model/ data/database data/files data/model-upload data/tmp
chown mendix:mendix /srv/mendix/mendix-app -R
chmod 700 model/ data/

# Create .m2ee directory for mendix user
log "Creating .m2ee directory..."
su - mendix -c "mkdir -p ~/.m2ee"

# Configure Mendix
log "Configuring Mendix..."
# Add your configuration commands here
# For example:
# echo "mxnode.mxjar_repo: https://download.mendix.com/runtimes/" > /home/mendix/.m2ee/m2ee.yaml
# chown mendix:mendix /home/mendix/.m2ee/m2ee.yaml

log "Mendix installation completed successfully!"
