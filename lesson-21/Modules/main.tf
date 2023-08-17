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

module "insatnce" {
  source = "/home/sargis/Terraform/lesson-21/Modules/instance"
}

output "private_ip" {
  description = "Private Ip from modul"
  value       = module.instance.aws_instance
}
