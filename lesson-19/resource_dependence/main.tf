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

resource "aws_instance" "app_server" {
  ami                    = "ami-04e601abe3e1a910f"
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  depends_on  = [aws_instance.db_server, aws_instance.backend_server]

  tags = local.common_tags
}

resource "aws_instance" "backend_server" {
  ami                    = "ami-04e601abe3e1a910f"
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  depends_on  = [aws_instance.db_server]

  tags = local.common_tags
}

resource "aws_instance" "db_server" {
  ami                    = "ami-04e601abe3e1a910f"
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = local.common_tags
}


resource "aws_security_group" "web_sg" {
  name        = "wb-sg"
  description = "Security Group for  web server"

  dynamic "ingress" {
    for_each = var.security_group_ingress_ports
    content {
    from_port   = ingress.value
    to_port     = ingress.value
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

