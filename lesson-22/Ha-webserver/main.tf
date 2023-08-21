 terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = " 5.10.0"
    }
  }
}

provider "aws" {
  default_tags {
    tags = {
      Owner = "Sargis Kaloyan"
    }
  }
}

### we need to use availability zones
data "aws_availability_zones" "working" {}

### we need  to get amazon ami from aws
data "aws_ami" "latest_amazon_linux" {
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["al2023-ami-2023.1.20230809.0-*-x86_64"]
  }
}

### get aws vpc and  two subnets
resource "aws_default_vpc" "default" {}

resource "aws_default_subnet" "default_az1" {
  availability_zone = data.aws_availability_zones.working.names[0]
}

resource "aws_default_subnet" "default_az2" {
  availability_zone = data.aws_availability_zones.working.names[1]
}

### we  need  to create security group and  open port 80 443
resource "aws_security_group" "web" {
  name        = "web-sg"
  description = "Dynamic Security Group"
  vpc_id      = aws_default_vpc.default.id

  dynamic "ingress" {
    for_each = ["80", "443"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

### we  need  to create  template
resource "aws_launch_template" "web_template" {
    name = "webserver-ha-lt"
    image_id = data.aws_ami.latest_amazon_linux.id
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.web.id]
    user_data = filebase64("${path.module}/user_data.sh")
}

### we  need  to  create  autoscaling group
resource "aws_autoscaling_group" "web" {
   name                = "webserver-ha-asg-${aws_launch_template.web_template.latest_version}"
   min_size            = 2
   max_size            = 2
   min_elb_capacity    = 2
   health_check_type   = "ELB"
   vpc_zone_identifier = [aws_default_subnet.default_az1.id, aws_default_subnet.default_az2.id]
   target_group_arns   = [aws_lb_target_group.web_tg.arn] 

   launch_template {
    id      = aws_launch_template.web_template.id
    version = aws_launch_template.web_template.latest_version
  }

   dynamic "tag" {
    for_each = {
      Name    = "WebServer in ASG-v${aws_launch_template.web_template.latest_version}"
      TAGKEY  = "TAGVALUE"
      Project = "DevOps"
    }
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true # dynamic block
    }
  }
  
  lifecycle {
    create_before_destroy = true
  }
}

### create load_balancer
resource "aws_lb" "web_lb" {
  name               = "webserver-ha-lb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web.id]
  subnets            = [aws_default_subnet.default_az1.id, aws_default_subnet.default_az2.id]
}

resource "aws_lb_target_group" "web_tg" {
  name                 = "webserver-tg"
  vpc_id               = aws_default_vpc.default.id
  port                 = 80
  protocol             = "HTTP"
  deregistration_delay = 15
}

resource "aws_lb_listener" "web_lister" {
  load_balancer_arn  = aws_lb.web_lb.arn
  port               = "80"
  protocol           = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}

output "loadbalancer_dns" {
  value = aws_lb.web_lb.dns_name
}
