resource "aws_launch_template" "asg_elb" {
  name                   = var.template_instance_name
  image_id               = data.aws_ami.debian.image_id
  instance_type          = var.instance_type
  key_name               = var.key_pair
  vpc_security_group_ids = [aws_security_group.asg_elb.id]
  user_data              = filebase64("${path.module}/userdata/instance_template_ud.sh")
  tags = local.instances.instance_template
}
