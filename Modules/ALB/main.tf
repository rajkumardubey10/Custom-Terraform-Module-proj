resource "aws_lb" "custom_lb" {
  name   = var.lb_name
  internal  = false
  load_balancer_type = "application"
  security_groups = var.lb_security_group_ids
  subnets         = var.lb_subnet_ids


  enable_deletion_protection = true

  tags = var.tags
 
}


resource "aws_lb_target_group" "alb_target_group" {
  name  = var.target_group_name
  target_type = "instance"
  port  = var.target_group_port
  protocol  = var.target_group_protocol
  vpc_id  = var.vpc_id


  health_check {
    path = var.health_check_path
    protocol = var.health_check_protocol
    healthy_threshold = 3
    unhealthy_threshold = 3
    timeout  = 5
    interval = 30
    matcher  = "200"
  }

  tags = var.tags
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.custom_lb.arn
  port  = var.lb_listener_port
  protocol  = var.lb_listener_protocol
  ssl_policy        = var.lb_listener_protocol == "HTTPS" ? var.ssl_policy : null
  certificate_arn   = var.lb_listener_protocol == "HTTPS" ? var.lb_listner_certificate_arn : null

  default_action {
    type  = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }

  tags = var.tags
}