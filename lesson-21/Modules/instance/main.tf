provider "aws" {
  region = "eu-central-1"
}

resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  tags = {
    Name = "main15-1"
  }
}

resource "aws_instance" "web" {
  ami           = "ami-04e601abe3e1a910f"
  instance_type = "t2.micro"
  key_name      = "Bdg"
  subnet_id     = "subnet-0eefe5576515661b3"

  tags = {
    Name = "Import test"
  }
}

output "aws_instance_ip" {
  value =  aws_instance.web.private_ip
}
