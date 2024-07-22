#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to log messages
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}

# Check if script is run as root
if [[ $EUID -ne 0 ]]; then
   log "This script must be run as root"
   exit 1
fi

# Update package lists
log "Updating package lists..."
apt update

# Install PostgreSQL
log "Installing PostgreSQL..."
apt install -y postgresql postgresql-contrib

# Start PostgreSQL service
log "Starting PostgreSQL service..."
systemctl start postgresql
systemctl enable postgresql

# Set PostgreSQL password for postgres user
POSTGRES_PASSWORD=$(openssl rand -base64 12)
log "Setting PostgreSQL password for postgres user..."
su - postgres -c "psql -c \"ALTER USER postgres WITH PASSWORD '$POSTGRES_PASSWORD';\""

# Create mendix user and database
log "Creating mendix user and database..."
su - postgres -c "psql -c \"CREATE USER mendix WITH PASSWORD '$POSTGRES_PASSWORD';\""
su - postgres -c "psql -c \"CREATE DATABASE mendix OWNER mendix;\""

# Grant privileges to mendix user
log "Granting privileges to mendix user..."
su - postgres -c "psql -c \"GRANT ALL PRIVILEGES ON DATABASE mendix TO mendix;\""

# Configure PostgreSQL for remote connections (optional, comment out if not needed)
log "Configuring PostgreSQL for remote connections..."
sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" /etc/postgresql/*/main/postgresql.conf
echo "host    all    all    0.0.0.0/0    md5" >> /etc/postgresql/*/main/pg_hba.conf

# Restart PostgreSQL to apply changes
log "Restarting PostgreSQL..."
systemctl restart postgresql

log "PostgreSQL installation and setup completed successfully!"
log "PostgreSQL version:"
su - postgres -c "psql -c 'SELECT version();'"
log "Database 'mendix' and user 'mendix' have been created."
log "PostgreSQL password for 'postgres' and 'mendix' users: $POSTGRES_PASSWORD"
log "Please make sure to save this password securely and update your Mendix configuration accordingly."
