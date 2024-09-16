  #!/bin/bash


        ## Author: Gurka Sathish
        ## Date  : 10-09-2024
        ## company: PearlThoughts
#step:1

# Installing PostgreSQL database on ubuntu
set -x
# Update the server
sudo apt update

# Install the PostgreSQL
sudo apt install postgresql postgresql-contrib

# Enable postgresql service
sudo systemctl enable postgresql

# Start the PostgreSQL if it is not started
sudo systemctl start postgresql

# Check the status of PostgreSQL
sudo systemctl status postgresql
