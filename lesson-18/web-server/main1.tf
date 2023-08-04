terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.10.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "ubuntu-vm-1" {
  ami           = "ami-04e601abe3e1a910f"
  instance_type = "t2.micro"
  key_name      = "Bdg"
  count         = 1
  #function
  user_data = <<EOF
#!/bin/bash
sudo apt-get update
sudo apt-get install nginx -y
sudo chkconfig nginx  enabled
sudo chmod 775 /var/www/html
sudo chown -R ubuntu:ubuntu /var/www/html
sudo bash -c "echo '<!DOCTYPE html> \
<html>
<head>
    <title>nginx</title>
</head>
<body>
    <h1>nginx</h1>
</body>
</html>' > /var/www/html/index.html"
sudo systemctl restart nginx
EOF

  tags = {
    Name  = "ubuntu-linux"
    Owner = "Sargis kaloyan"
  }

  vpc_security_group_ids = [aws_security_group.ubuntu-sg-1.id]
}

resource "aws_security_group" "ubuntu-sg-1" {
  name        = "wb-sg"
  description = "my first sg in  terraform"

   ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
