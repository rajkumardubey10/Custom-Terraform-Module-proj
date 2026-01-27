# ==============================
# Project
# ==============================

project_name_root = "payments-dev"

tags_root = {
  Environment = "dev"
  Owner       = "platform-team"
  ManagedBy   = "terraform"
}

common_tags = {
  Project = "asg-alb-demo"
  Env     = "dev"
}


# ==============================
# VPC
# ==============================

vpc_cidr_root = "10.0.0.0/16"

public_subnets_root = {
  ap-south-1a = "10.0.1.0/24"
  ap-south-1b = "10.0.2.0/24"
}

private_subnets_root = {
  ap-south-1a = "10.0.101.0/24"
  ap-south-1b = "10.0.102.0/24"
}


# ==============================
# Security Groups
# ==============================

security_groups_root = {

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
      },
      {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
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


# ==============================
# ALB
# ==============================

lb_name_root = "payments-alb"

target_group_name_root     = "payments-tg"
target_group_protocol_root = "HTTP"
target_group_port_root     = 8080

health_check_path_root     = "/"
health_check_protocol_root = "HTTP"

lb_listener_port_root      = 80
lb_listener_protocol_root  = "HTTP"

# No SSL for testing
ssl_policy_root = null
lb_listner_certificate_arn_root = null


# ==============================
# Auto Scaling / EC2
# ==============================

asg_name_root = "payments-asg"

# Amazon Linux 2 (Mumbai Region)
ami_id_root = "ami-0f5ee92e2d63afc18"

instance_type_root = "t3.micro"

# ⚠️ CHANGE THIS to your real keypair name
key_name_root = "my-keypair"

# Leave empty if not using IAM role
iam_instance_profile_name_root = ""


# ==============================
# User Data (Install Nginx)
# ==============================

user_data_root = <<EOF
#!/bin/bash
yum update -y
yum install -y nginx
systemctl start nginx
systemctl enable nginx
echo "Hello from ASG $(hostname)" > /usr/share/nginx/html/index.html
EOF


# ==============================
# Auto Scaling Config
# ==============================

min_size_root = 1
max_size_root = 2

# Used only if request-based scaling is enabled
alb_resource_label_root = null
