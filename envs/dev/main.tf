provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source = "../../Modules/vpc"

  project         = var.project_name_root
  aws_vpc_cdir    = var.vpc_cidr_root
  public_subnets  = var.public_subnets_root
  private_subnets = var.private_subnets_root
  tags            = var.tags_root
}

module "security_group" {
  for_each = var.security_groups
  source   = "./Modules/security-group"

  sg_name = each.key
  vpc_id  = module.vpc.vpc_id

  ingress_rules = each.value.ingress_rules
  egress_rules  = lookup(each.value, "egress_rules", null)

  tags = var.common_tags
}

module "alb" {
  source = "../../modules/alb"

  lb_name               = var.lb_name
  lb_security_group_ids = [module.security_group["alb-sg"].sg_id]
  lb_subnet_ids         = module.vpc.public_subnet_ids

  vpc_id                = module.vpc.vpc_id
  target_group_name     = var.target_group_name
  target_group_protocol = var.target_group_protocol
  target_group_port     = var.target_group_port

  health_check_path     = var.health_check_path
  health_check_protocol = var.health_check_protocol

  lb_listener_port      = var.lb_listener_port
  lb_listener_protocol  = var.lb_listener_protocol
  ssl_policy            = var.ssl_policy
  lb_listner_certificate_arn = var.lb_listner_certificate_arn

  tags = var.common_tags
}

