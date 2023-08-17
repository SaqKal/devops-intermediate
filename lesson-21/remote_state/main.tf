terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.10.0"
    }
  }
  backend "s3" {
    bucket = "sargis-kaloyan"
    key    = "lesson-5/dev/terraform.tfstate"
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

