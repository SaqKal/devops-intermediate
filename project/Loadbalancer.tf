 resource "aws_lb" "asg_elb" {
   name               = var.load_balancer_name
   internal           = false
   load_balancer_type = var.load_balancer_type
   enable_deletion_protection = false
   enable_http2 = true
   idle_timeout = 60
   subnets = [aws_subnet.asg_elb_1.id, aws_subnet.asg_elb_2.id]
 }


 resource "aws_lb_listener" "asg_elb" {
   load_balancer_arn = aws_lb.asg_elb.arn
   port              = 3000
   protocol          = "HTTP"

   default_action {
     type = "forward"
     target_group_arn = aws_lb_target_group.asg_elb.arn
   }
 }

 resource "aws_lb_target_group" "asg_elb" {
   name     = "example-tg"
   port     = 3000
   protocol = "HTTP"
   vpc_id   = aws_vpc.my_vpc.id

   health_check {
     path                = "/"
     port                = 3000
     protocol            = "HTTP"
     unhealthy_threshold = 2
     healthy_threshold   = 2
     timeout             = 3
     interval            = 30
   }
 }
