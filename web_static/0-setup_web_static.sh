#!/usr/bin/env bash
# Script to set up web servers for the deployment of web_static

# Install Nginx if it is not already installed
if ! command -v nginx &> /dev/null; then
    sudo apt-get update
    sudo apt-get install -y nginx
fi

# Create necessary directories
sudo mkdir -p /data/web_static/releases/test/
sudo mkdir -p /data/web_static/shared/

# Create a fake HTML file to test Nginx configuration
echo "<html>
  <head>
  </head>
  <body>
    Holberton School
  </body>
</html>" | sudo tee /data/web_static/releases/test/index.html

# Create a symbolic link
if [ -L /data/web_static/current ]; then
    sudo rm /data/web_static/current
fi
sudo ln -s /data/web_static/releases/test/ /data/web_static/current

# Give ownership of the /data/ folder to the ubuntu user and group recursively
sudo chown -R ubuntu:ubuntu /data/

# Update Nginx configuration
nginx_config="server {
    listen 80;
    listen [::]:80;

    server_name _;

    location /hbnb_static {
        alias /data/web_static/current;
        index index.html index.htm;
    }

    location / {
        try_files \$uri \$uri/ =404;
    }
}"

# Write the Nginx configuration file
echo "$nginx_config" | sudo tee /etc/nginx/sites-available/default

# Restart Nginx to apply the changes
sudo service nginx restart

# Exit successfully
exit 0
