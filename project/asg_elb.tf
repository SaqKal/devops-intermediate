resource "aws_autoscaling_group" "asg_elb" {
   name_prefix          = var.asg_name
   launch_template {
     id      = aws_launch_template.asg_elb.id
     version = aws_launch_template.asg_elb.latest_version
   }

   min_size             = 1
   max_size             = 3
   desired_capacity     = 2
   vpc_zone_identifier  = [aws_subnet.asg_elb_1.id, aws_subnet.asg_elb_2.id]  # Replace with your subnet IDs
   depends_on = [
     aws_subnet.asg_elb_1,
     aws_subnet.asg_elb_2,
     aws_lb.asg_elb,
     aws_lb_target_group.asg_elb
   ]
   target_group_arns = [aws_lb_target_group.asg_elb.arn]
   dynamic "tag" {
     for_each = {
       Name        = local.asg.instances.Name
       Description = local.asg.instances.Description
     }
     content {
       key                 = tag.key
       value               = tag.value
       propagate_at_launch = true
     }
   }
   lifecycle {
     create_before_destroy = true
   }
 }
