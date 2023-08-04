#!/bin/bash
sudo apt-get update
sudo apt-get install nginx -y
sudo chkconfig nginx  enabled
sudo chmod 775 /var/www/html
sudo chown -R ubuntu:ubuntu /var/www/html
sudo bash -c  "echo '<!DOCTYPE html> \
<html>
<head>
    <title>nginx</title>
</head>
<body>
    <h1>nginx</h1>
</body>
</html>' > /var/www/html/index.html"
sudo systemctl restart nginx


