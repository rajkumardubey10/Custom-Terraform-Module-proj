
# ALB ARN
output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value = aws_lb.custom_lb.arn
}

# ALB DNS Name
output "alb_dns_name" {
  description = "DNS name of the ALB"
  value = aws_lb.custom_lb.dns_name
}

# ALB Hosted Zone ID
output "alb_zone_id" {
  description = "Route53 zone ID used to create alias record for the ALB"
  value = aws_lb.custom_lb.zone_id
}

# ALB ARN Suffix
output "alb_arn_suffix" {
  description = "ARN suffix of ALB used for CloudWatch logs or WAF"
  value = aws_lb.custom_lb.arn_suffix
}

# ALB Security Group ID
output "alb_security_group_id" {
  description = "Security group ID attached to the ALB"
  value = var.lb_security_group_ids
}

# Listener ARN
output "listener_arn" {
  description = "ARN of the ALB listener"
  value = aws_lb_listener.lb_listener.arn
}

# Target Group ARN
output "target_group_arn" {
  description = "ARN of the Target Group"
  value = aws_lb_target_group.alb_target_group.arn
}

# Target Group Name
output "target_group_name" {
  description = "Name of the Target Group"
  value = aws_lb_target_group.alb_target_group.name
}
