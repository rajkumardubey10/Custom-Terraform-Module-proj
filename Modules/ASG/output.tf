output "asg_name" {
  value = aws_autoscaling_group.custom_asg.name
}

output "asg_arn" {
  value = aws_autoscaling_group.custom_asg.arn
}

output "launch_template_id" {
  value = aws_launch_template.custom_lt.id
}
