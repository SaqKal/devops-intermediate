resource "aws_security_group" "jenkins" {
  name        = "Jenkins Master"
  description = "Jenkins Master SG"
  vpc_id      = aws_vpc.my_vpc.id
  dynamic "ingress" {
    for_each = ["443", "8080", "22"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  depends_on = [aws_subnet.jenkins]
}

resource "aws_security_group" "jenkins_worker" {
  name        = "Jenkins Worker"
  description = "Jenkins Worker SG"
  vpc_id      = aws_vpc.my_vpc.id
  dynamic "ingress" {
    for_each = [
      "8081",
      "8080",
      "3000",
      "27017",
      "443",
      "22"
    ]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  depends_on = [aws_subnet.jenkins_worker]
}

resource "aws_security_group" "asg_elb" {
  name        = "ASG and ELB"
  description = "Security group for ASG and Load Balancer"
  vpc_id      = aws_vpc.my_vpc.id
  dynamic "ingress" {
    for_each = [
      "8081",
      "8080",
      "3000",
      "27017",
      "443",
      "22"
    ]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  depends_on = [
    aws_subnet.asg_elb_1,
    aws_subnet.asg_elb_2
  ]
}
