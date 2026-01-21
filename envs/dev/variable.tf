variable "project_name_root" {
  type = string
}

variable "vpc_cidr_root" {
  type = string
}

variable "public_subnets_root" {
  type = map(string)
}

variable "private_subnets_root" {
  type = map(string)
}

variable "tags_root" {
  type = map(string)
}

## sg variable 

variable "security_groups" {
  description = "Security groups configuration"
  type = map(object({
    ingress_rules = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = optional(list(string))
    }))
    egress_rules = optional(list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = optional(list(string))
    })))
}))

}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
}

## alb 

variable "lb_name" {
  type = string
}

variable "target_group_name" {
  type = string
}

variable "target_group_protocol" {
  type = string
}

variable "target_group_port" {
  type = number
}

variable "health_check_path" {
  type = string
}

variable "ssl_policy" {
  type = string
}
variable "health_check_protocol" {
  type = string
}

variable "lb_listener_protocol" {
  type = string
}

variable "lb_listener_port" {
  type = number
}

variable "lb_listner_certificate_arn" {
  type    = string
  default = null
}

variable "common_tags" {
  type = map(string)
}
