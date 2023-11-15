resource "aws_subnet" "jenkins" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.subnet_cidrs["jenkins"]
  availability_zone       = var.availability_zones["1"]
  map_public_ip_on_launch = true
  tags                    = local.subnets.jenkins
}

resource "aws_subnet" "jenkins_worker" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.subnet_cidrs["jenkins_worker"]
  availability_zone       = var.availability_zones["1"]
  map_public_ip_on_launch = true
  tags                    = local.subnets.jenkins_worker
}
resource "aws_subnet" "asg_elb_1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.subnet_cidrs["asg_elb_1"]
  availability_zone       = var.availability_zones["1"]
  map_public_ip_on_launch = true
}

resource "aws_subnet" "asg_elb_2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.subnet_cidrs["asg_elb_2"]
  availability_zone       = var.availability_zones["2"]
  map_public_ip_on_launch = true
}
