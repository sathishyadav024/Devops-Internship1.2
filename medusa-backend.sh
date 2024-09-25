 #!/bin/bash


        ## Author: Gurka Sathish
        ## Date  : 10-09-2024
        ## company: PearlThoughts
# Update system and install necessary dependencies
          sudo apt update && sudo apt upgrade -y
          sudo apt install -y git
          sudo apt install -y nodejs npm git postgresql redis-server
          sudo systemctl enable postgresql
          sudo systemctl start postgresql
          sudo systemctl enable redis-server

          # Set up PostgreSQL for Medusa-backend
          sudo -u postgres psql -c "CREATE USER medusa_user WITH PASSWORD 'sathish';" || true
          sudo -u postgres psql -c "CREATE DATABASE medusa_db;" || true
          sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE medusa_db TO medusa_user;" || true

           # Grant additional permissions to the user
          sudo -u postgres psql -d medusa_db -c "GRANT ALL PRIVILEGES ON SCHEMA public TO medusa_user;"

          # Configure PostgreSQL authentication method
          sudo sh -c 'echo "host all all 0.0.0.0/0 md5" >> /etc/postgresql/16/main/pg_hba.conf'

           # Reload PostgreSQL to apply configuration changes
          sudo systemctl reload postgresql


          # Install Medusa CLI
          sudo npm install -g @medusajs/medusa-cli

          # Create a new Medusa project
          mkdir medusa-backend && cd medusa-backend
          sudo medusa new . --skip-db

          # Update the .env file to connect to the correct PostgreSQL database
          echo "DATABASE_URL=postgres://medusa_user:sathish@localhost:5432/medusa_db" | sudo tee .env
          # Add Redis URL to the .env file
          echo "REDIS_URL=redis://localhost:6379" | sudo tee -a .env
          sudo chown $USER:$USER .env && chmod 644 .env
          
          # run migrations
          sudo medusa migrations run
          # set admin user-name and password 
          sudo medusa user --email sathishyadavdiploma@gmail.com --password sathish

          # Start Medusa backend
          nohup sudo medusa start &> medusa.log &
