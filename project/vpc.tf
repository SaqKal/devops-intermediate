resource "aws_vpc" "my_vpc" {
  cidr_block                       = var.vpc_cidr
  instance_tenancy                 = "default"
  enable_dns_support               = true
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = false
  tags                             = local.vpc
}

resource "aws_internet_gateway" "my_vpc" {
  vpc_id = aws_vpc.my_vpc.id
  tags   = local.igw
}
