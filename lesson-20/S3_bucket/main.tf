terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.10.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

resource "random_string" "random" {
  length  = 17
  special = false
  upper   = false
}

output "random_string_random" {
  value =  random_string.random.id
}

resource "aws_s3_bucket" "sargis" {
  bucket = "remote-state1-${random_string.random.id}"

  tags = {
    Owner      = "sargis"
    Name       = "remote state"
    Enviroment = "Dev"
  }
}

resource "aws_s3_object" "object" {
  bucket     = "remote-state1-${random_string.random.id}"
  key        = "index.html"
  source     = "index.html"
  depends_on = [aws_s3_bucket.sargis]
}
