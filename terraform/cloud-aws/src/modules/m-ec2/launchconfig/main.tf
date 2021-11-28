resource "aws_launch_configuration" "config" {
  associate_public_ip_address = var.associate_public_ip_address
  iam_instance_profile        = var.iam_instance_profile
  image_id                    = var.image_id
  instance_type               = var.instance_type
  name_prefix                 = var.name_prefix
  security_groups             = var.security_groups
  key_name                    = var.key_name
  user_data_base64            = var.user_data_base64

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 500
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

