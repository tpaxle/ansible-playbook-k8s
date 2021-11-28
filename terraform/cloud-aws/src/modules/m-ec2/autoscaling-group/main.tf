resource "aws_autoscaling_group" "group" {
  desired_capacity     = var.desired_capacity
  launch_configuration = var.launch_config_id

  max_size            = var.max_size
  min_size            = var.min_size
  name                = var.name
  vpc_zone_identifier = var.subnet_ids

  tag {
    key                 = "Name"
    value               = var.name
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${var.cluster_id}"
    value               = "owned"
    propagate_at_launch = true
  }
}

