
# `Integrate and install Medusa_backend on Amazon EC2`

This project demonstrates how to deploy the Medusa backend on an Amazon EC2 instance. The deployment process is Manual , making it simple to set up and run the Medusa e-commerce platform.









## 🔗 Links
[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/sathish-gurka)


## Authors

- [@GurkaSathish](https://github.com/sathishyadav024)


## `Pre-Requisites`

Before starting, make sure you have the following:

- `An AWS account`

- `An Amazon EC2 instance running a Linux-based OS (e.g., Ubuntu)`

- `SSH access to your EC2 instance`

- `Basic knowledge of Linux terminal commands`
## `Process`

`Step 1: Launch an Amazon EC2 Instance`
```
Create an EC2 instance:

Log into your AWS Console.

Navigate to the EC2 Dashboard and launch a new instance.

Choose Ubuntu 22.04 or a similar Linux distribution as the Amazon Machine Image (AMI).

Select an appropriate instance type (e.g., t2.micro for free tier).

Configure security group rules to allow:

SSH (port 22) for remote access.

HTTP (port 80) for web traffic.

Medusa backend (port 9000).

```

`Step-2: SSH into the EC2 Instaance`
```
ssh -i <your-key-pair.pem> ubuntu@<your-ec2-public-ip>
```

`Step-3: Run the medusa-backend.sh Script`

```
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
```
## `Technologies Used`

- `AWS EC2`

- `Medusa-Headless e-commerce`

- `Scripting`
  
## `Contact`


   For any inquiries or issues related to this project, please reach out via email:  
   
   
   Author: `Gurka Sathish`
   
   Email: ` sathishgurka@gmail.com `
## `Conclusion`

You have now manually installed and configured the Medusa backend on an AWS EC2 instance. Medusa is running on port 9000, and you can access it using the EC2 instance’s public IP. 
