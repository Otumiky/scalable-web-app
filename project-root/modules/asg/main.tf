resource "aws_launch_template" "lt" {
  name_prefix   = var.name_prefix
  image_id      = var.image_id
  instance_type = var.instance_type

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = var.security_groups
  }

  user_data = base64encode(var.user_data)
}

resource "aws_autoscaling_group" "asg" {
  desired_capacity     = var.desired_capacity
  min_size             = var.min_size
  max_size             = var.max_size
  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }
  vpc_zone_identifier  = var.subnets
  target_group_arns    = [var.target_group_arn]

  tag {
    key                 = "Name"
    value               = var.name_prefix
    propagate_at_launch = true
  }
}
