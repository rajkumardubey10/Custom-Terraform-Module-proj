variable "lb_name" {
  type = string
  default = " "
}

variable "lb_security_group_ids" {
  type = list(string)
  description = "List of security group IDs to attach to the ALB"
}

variable "lb_subnet_ids" {
  type = list(string)
  description = "List of subnets (public) where ALB will be created"
}

variable "health_check_path" {
  description = "Health check path"
  type   = string
  default = "/"
}

variable "health_check_protocol" {
  type = string
}

variable "vpc_id" {
  type  = string
  description = "VPC ID where ALB target group will be created"
}

variable "target_group_protocol" {
  type = string
  description = "target group protocol for http"
  default = "HTTP"
}

variable "target_group_port" {
  type = number
  default = 80
}

variable "target_group_name" {
  type = string

}

variable "lb_listener_port" {
  type = number
  default = 80
}
variable "lb_listener_protocol" {
  type = string
  description = "Load Balancer listner protocol for http"
  default = "HTTP"

  validation {
    condition     = var.lb_listener_protocol == "HTTP" || var.lb_listener_protocol == "HTTPS"
    error_message = "lb_listener_protocol must be either HTTP or HTTPS."
  }
}

variable "ssl_policy" {
  type    = string
  default = "ELBSecurityPolicy-2016-08"
}

variable "lb_listner_certificate_arn" {
  description = "SSL certificate ARN for HTTPS listener"
  type        = string
}

variable "tags" {
  type = map(string)
}