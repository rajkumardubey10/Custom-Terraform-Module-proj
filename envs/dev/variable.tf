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

variable "security_groups_root" {
  description = "Security groups configuration"
  type = map(any)

}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
}

## alb 

variable "lb_name_root" {
  type = string
}

variable "target_group_name_root" {
  type = string
}

variable "target_group_protocol_root" {
  type = string
}

variable "target_group_port_root" {
  type = number
}

variable "health_check_path_root" {
  type = string
}

variable "ssl_policy_root" {
  type = string
}
variable "health_check_protocol_root" {
  type = string
}

variable "lb_listener_protocol_root" {
  type = string
}

variable "lb_listener_port_root" {
  type = number
}

variable "lb_listner_certificate_arn_root" {
  type    = string
  default = null
}

## Autoscaling groups 

variable "asg_name_root" {
  type = string
}

variable "ami_id_root" {
  type = string
}

variable "instance_type_root" {
  type = string
}

variable "key_name_root" {
  type = string
}

variable "iam_instance_profile_name_root" {
  type = string
}

variable "user_data_root" {
  type = string
}

variable "max_size_root" {
  type = number
}

variable "min_size_root" {
  type = number
}


variable "alb_resource_label_root" {
  type = string
}
