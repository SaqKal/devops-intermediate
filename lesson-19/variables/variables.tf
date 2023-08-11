variable "instance_type" {
  default = "t2.micro"
}

variable "owner" {
  default = "Sargis kaloyan"
}

locals {
  common_tags = {
    Owner = "Sargis Kaloyan"
  }
}

variable "security_group_ingress_ports" {
  type    = list(any)
  default = ["80", "443", "8080", "22"]
}

output "aws_instance_id" {
  value = aws_instance.app_server.id
}

output "aws_instance_arn" {
  value = aws_instance.app_server.arn
}

output "aws_instance_public_ip" {
  value = aws_instance.app_server.public_ip
}

output "aws_security_group_id" {
  value = aws_security_group.web_sg.id
}

output "aws_security_group_vpc_id" {
  value = aws_security_group.web_sg.vpc_id
}
