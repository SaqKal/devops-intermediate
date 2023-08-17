terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.10.0"
    }
  }
  backend "s3" {
    bucket = "sargis-kaloyan"
    key    = "lesson-5/import/terraform.tfstate"
    region = "eu-central-1"    
  }
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.5.0.0/16"
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
