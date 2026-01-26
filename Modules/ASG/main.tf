resource "aws_launch_template" "custom_lt" {
  name_prefix = "${var.asg_name}-lt-"
  image_id = var.ami_id
  instance_type = var.instance_type
  key_name = var.key_name

  iam_instance_profile {
    name = var.iam_instance_profile_name
  }

  vpc_security_group_ids = var.security_group_ids

  tag_specifications {
    resource_type = "instance"
    tags = merge(
      { Name = var.asg_name},
      var.tags
    )
  }

  user_data = var.user_data != null ? base64encode(var.user_data) : null

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_autoscaling_group" "custom_asg" {
  name                      = var.asg_name
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = 300
  health_check_type         = "ELB"
  termination_policies      = ["OldestInstance"]
  force_delete              = var.force_delete
#   placement_group           = aws_placement_group.test.id
#   launch_configuration      = aws_launch_configuration.foobar.name
  vpc_zone_identifier       = var.subnet_ids

  launch_template {
    id      = aws_launch_template.custom_lt.id
    version = "$Latest"
  }
  
   tag {
    key = "Name"
    value = var.asg_name
    propagate_at_launch = true
  }
  
  instance_maintenance_policy {
    min_healthy_percentage = 90
    max_healthy_percentage = 120
  }
}


resource "aws_autoscaling_policy" "cpu_use" {
  count                  = var.enable_cpu_scaling ? 1 : 0
  name                   = "${var.asg_name}-cpu-scaling"
  autoscaling_group_name = aws_autoscaling_group.custom_asg.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = var.cpu_target_value
  }
}

resource "aws_autoscaling_policy" "request_per_target" {
  count                  = var.enable_request_scaling ? 1 : 0
  name                   = "${var.asg_name}-request-scaling"
  autoscaling_group_name = aws_autoscaling_group.custom_asg.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
	    resource_label         = var.alb_resource_label
    }
    target_value = var.requests_per_target
  }
}