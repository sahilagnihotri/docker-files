#!/bin/bash
# ----------------------------------------------------------

# Get the current working directory
CURRENT_DIR=$(pwd)
echo "The current working directory is: $CURRENT_DIR"

# Wget data
mkdir -p $CURRENT_DIR/osm_data
wget -P $CURRENT_DIR/osm_data https://download.geofabrik.de/africa/tunisia-latest.osm.pbf

# Create folders to store volumes
echo "Creating directories for Docker volumes..."
mkdir -p $CURRENT_DIR/volumes/grafana_data
mkdir -p $CURRENT_DIR/volumes/prometheus_data
mkdir -p $CURRENT_DIR/volumes/portainer_data
mkdir -p $CURRENT_DIR/volumes/osm_data

# Apply permissions to the volumes folder
chmod -R 775 $CURRENT_DIR/volumes
echo "Permissions updated for $CURRENT_DIR/volumes."

# Define the home directory explicitly
HOME_DIR=$(echo $HOME)

# Specify the path to your docker-compose.yml file
COMPOSE_FILE="$CURRENT_DIR/docker-compose.yml"

# Create a backup of the original docker-compose.yml file
echo "Creating a backup of docker-compose.yml..."
cp "$COMPOSE_FILE" "$COMPOSE_FILE.backup"
echo "Backup created at $COMPOSE_FILE.backup"

# Use sed to replace all instances of '~' with the absolute home directory path
echo "Updating paths in docker-compose.yml..."
sed -i.bak "s|~|$HOME_DIR|g" "$COMPOSE_FILE"
echo "Replaced '~' with '$HOME_DIR' in $COMPOSE_FILE."

# Notify about automatic backup by sed
echo "Automatic backup by sed: $COMPOSE_FILE.bak."

# ----------------------------------------------------------
echo "Script execution completed successfully!"
