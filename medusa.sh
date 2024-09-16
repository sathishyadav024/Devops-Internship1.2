#!/bin/bash

# Enable debug mode for the script
set -x

# Step 2: Installing Medusa Backend application

# Install npm and curl if not installed
sudo apt update
sudo apt install -y npm curl

# Install Node.js 18
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs

# Install medusa-cli globally
sudo npm install -g @medusajs/medusa-cli

# Create a directory for the Medusa backend server
mkdir medusa-backend-server
cd medusa-backend-server

# Initialize a new Medusa project
medusa new .

# Step 5: Create admin user
# Replace with your desired admin email and password
ADMIN_EMAIL="sathishgurka@gmail.com"
ADMIN_PASSWORD="sathish"

echo "Creating admin user..."
medusa user -e $ADMIN_EMAIL -p $ADMIN_PASSWORD

# Run medusa migrations
medusa migrations run

# Start the Medusa server
medusa develop
