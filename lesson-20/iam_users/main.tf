terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.10.0"
    }
  }
}

resource "aws_iam_user" "admin-user" {
  name = "student"
  tags = {
    Description = " for DevOps  lessons"
  }
}
