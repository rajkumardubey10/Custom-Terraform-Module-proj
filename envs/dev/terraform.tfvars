project_name_root = "payments-dev"
vpc_cidr_root     = "10.0.0.0/16"

public_subnets_root = {
  ap-south-1a = "10.0.1.0/24"
  ap-south-1b = "10.0.2.0/24"
}

private_subnets_root = {
  ap-south-1a = "10.0.101.0/24"
  ap-south-1b = "10.0.102.0/24"
}

tags_root = {
  Environment = "dev"
  Owner       = "platform-team"
  ManagedBy   = "terraform"
}

## sg .tfvars

security_groups = {

  alb-sg = {
    ingress_rules = [
      {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  }

  app-sg = {
    ingress_rules = [
      {
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
      }
    ]
  }

  db-sg = {
    ingress_rules = [
      {
        from_port   = 5432
        to_port     = 5432
        protocol    = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
      }
    ]
  }
}

common_tags = {
  Project = "asg-alb-demo"
  Env     = "dev"
}
