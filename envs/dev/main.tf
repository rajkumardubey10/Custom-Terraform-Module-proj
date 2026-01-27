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
  for_each = var.security_groups_root
  source   = "../../Modules/security_group"

  sg_name = each.key
  vpc_id  = module.vpc.vpc_id

  ingress_rules = each.value.ingress_rules
  egress_rules  = lookup(each.value, "egress_rules", [])

  tags = var.common_tags
}

module "alb" {
  source = "../../modules/alb"

  lb_name               = var.lb_name_root 
  lb_security_group_ids = [module.security_group["alb-sg"].security_group_id]
  lb_subnet_ids         = values(module.vpc.public_subnet_ids)

  vpc_id                = module.vpc.vpc_id
  target_group_name     = var.target_group_name_root
  target_group_protocol = var.target_group_protocol_root
  target_group_port     = var.target_group_port_root

  health_check_path     = var.health_check_path_root
  health_check_protocol = var.health_check_protocol_root

  lb_listener_port      = var.lb_listener_port_root
  lb_listener_protocol  = var.lb_listener_protocol_root
  ssl_policy            = var.ssl_policy_root
  lb_listner_certificate_arn = var.lb_listner_certificate_arn_root

  tags = var.common_tags
}

module "ASG" {
  source = "../../Modules/asg"

  # Launch template 
  asg_name = var.asg_name_root
  ami_id = var.ami_id_root 
  instance_type = var.instance_type_root
  key_name = var.key_name_root

  # Iam Instance Profile
  iam_instance_profile_name = var.iam_instance_profile_name_root

  # Security group
  security_group_ids = [module.security_group["app-sg"].security_group_id]
  target_group_arns = [module.alb.target_group_arn]

  # user data 
  user_data = var.user_data_root

  # Autoscaling_group
  max_size = var.max_size_root
  min_size = var.min_size_root
  subnet_ids = values(module.vpc.private_subnet_ids)
  alb_resource_label = var.alb_resource_label_root

}


