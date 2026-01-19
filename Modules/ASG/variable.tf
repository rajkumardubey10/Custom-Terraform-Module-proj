variable "asg_name" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "iam_instance_profile_name" {
  type = string
  default = ""
}

variable "security_group_ids" {
  type = list(string)
}

variable "subnet_ids" {
  type = list(string)
}

variable "target_group_arns" {
  type = list(string)
}

variable "key_name" {
  type    = string
  default = null
}

variable "user_data" {
  type    = string
  default = null
}

variable "min_size" {
  type = number
}

variable "max_size" {
  type = number
}

variable "force_delete" {
  type = bool
  default = false
}
# Scaling flags
variable "enable_cpu_scaling" {
  type    = bool
  default = true
}

variable "cpu_target_value" {
  type    = number
  default = 70
}

variable "enable_request_scaling" {
  type    = bool
  default = false
}

variable "requests_per_target" {
  type    = number
  default = 1000
}

variable "alb_resource_label" {
  type    = string
  default = null
}

variable "tags" {
  type    = map(string)
  default = {}
}
