#!/bin/bash
sudo apt-get update
sudo apt-get install nginx -y
sudo chkconfig nginx  enabled
sudo chmod 775 /var/www/html
sudo chown -R ubuntu:ubuntu /var/www/html

echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html

cat <<EOF > /var/www/html/index.html
<html>
<h2>Build by Power of Terraform <font color="red"> v1.5.4</font></h2><br>
Owner ${first_name} ${last_name} <br>

%{ for i in names ~}
Intermidate 2 group members ${i}<br>
%{ endfor ~}

%{ for x in names ~}
Hello to ${x} from ${first_name}<br>
%{ endfor ~}

sudo systemctl restart nginx


