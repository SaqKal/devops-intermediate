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
  user_data = templatefile("/home/sargis/Terraform/lesson-2/web-server-template/user_data.tpl",{
    first_name = "Sargis",
    last_name  = "Kaloyan",
    names      = ["Areg", "Sergey", "Hovhannes", "Sargis"]
  })

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

