variable "aws_vpc_cdir" {
   type  = string
   description = "CIDR block for VPC"
}

variable "tags" {
  type  = map(string)
  default  = {}
}

variable "project" {
  type  = string
  description = "Project name for tagging"
}

variable "public_subnets" {
  type = map(string)
}

variable "private_subnets" {
  type = map(string)
}
