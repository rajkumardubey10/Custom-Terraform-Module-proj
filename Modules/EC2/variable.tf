variable "instance_type" {
  type = string
  description = "we put the ec2 instance type which give the memeory and CPU "
  default = "t3.micro"
}

variable "tags" {
  type = map(string)
  description = "we write the ec2 instance name or tag it will helps to monitor the usage"
  default = {}
}

variable "key_pair_name" {
  type = string
  description = "we give the perfix name for terraform public key pair"
  default = ""
}

variable "iam_instance_profile" {
  description = "IAM instance profile name to attach to EC2"
  type        = string
  default     = null
}

variable "associate_public_ip" {
  description = "Whether to associate a public IP address"
  type        = bool
  default     = false
}

variable "user_data_script" {
  type        = optional(string)
  default     = ""
  description = "Path to user data script"
}

variable "root_volume_size" {
  description = "Root volume size in GB"
  type        = number
  default     = 20
}

variable "root_volume_type" {
  description = "Type of root EBS volume"
  type        = string
  default     = "gp3"
}

variable "root_volume_encrypted" {
  description = "Whether to encrypt the root volume"
  type        = bool
  default     = true
}



variable "instances" {
  description = "This will map all EC2 instance configuration for all multipe ec2 instances "
  type = map(object({
    subnet_id              = string
    vpc_security_group_ids = list(string)
    tags = optional(map(string))
  }))
}
