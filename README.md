# Custom-Terraform-Module-projects
## 🚀 AWS Infrastructure with Terraform (VPC + ALB + ASG)

This project provisions a complete AWS infrastructure using Terraform with a modular architecture.

It deploys:

- Custom VPC
- Public & Private Subnets (Multi-AZ)
- Internet Gateway & NAT Gateway
- Security Groups
- Application Load Balancer (ALB)
- Auto Scaling Group (ASG)
- EC2 Instances with User Data

This setup is suitable for dev, staging, and production environments.

---

## 🏗️ Architecture Overview

```
Internet
   |
   ▼
Application Load Balancer (Public Subnets)
   |
   ▼
Auto Scaling Group (Private Subnets)
   |
   ▼
EC2 Instances
```

---

## 📂 Project Structure

```
.
├── main.tf
├── variables.tf
├── terraform.tfvars
├── provider.tf
├── outputs.tf
│
└── Modules/
    ├── vpc/
    ├── security_group/
    ├── alb/
    └── asg/
```

---

## ⚙️ Prerequisites

Make sure you have:

- Terraform >= 1.3
- AWS Account
- AWS CLI configured
- EC2 Key Pair

Configure AWS:

```bash
aws configure
```

---

## 📝 Configuration

All environment-specific values are stored in:

```
terraform.tfvars
```

## 📝 Sample `terraform.tfvars` Configuration

Create a file named `terraform.tfvars` in the project root and add the following values before deployment.

This file contains environment-specific configuration.

---

### Example `terraform.tfvars`

```hcl
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

lb_listener_port_root     = 80
lb_listener_protocol_root = "HTTP"

ssl_policy_root = null
lb_listner_certificate_arn_root = null


# ==============================
# Auto Scaling / EC2
# ==============================

asg_name_root = "payments-asg"

# Amazon Linux 2 (Mumbai Region)
ami_id_root = "ami-0f5ee92e2d63afc18"

instance_type_root = "t3.micro"

# Change to your EC2 key pair name
key_name_root = "my-keypair"

# Leave empty if not required
iam_instance_profile_name_root = ""


# ==============================
# User Data
# ==============================

user_data_root = <<EOF
#!/bin/bash
yum install -y nginx
systemctl start nginx
systemctl enable nginx
EOF


# ==============================
# Auto Scaling
# ==============================

min_size_root = 1
max_size_root = 2

# Used only for request-based scaling
alb_resource_label_root = null
```

---

### ⚠️ Important Notes

- Replace `key_name_root` with your EC2 key pair name
- Update `ami_id_root` if required
- Modify CIDR ranges if they conflict with existing networks
- Do not commit sensitive values to public repositories

---

### 📌 Multiple Environments

For multiple environments, create separate files:

```
terraform-dev.tfvars
terraform-stage.tfvars
terraform-prod.tfvars
```

Usage:

```bash
terraform apply -var-file=terraform-prod.tfvars
```






Update this file before deployment:

```hcl
key_name_root = "your-keypair-name"
instance_type_root = "t3.micro"
```

---

## 🚀 Deployment Steps

### 1. Initialize Terraform

```bash
terraform init
```

### 2. Validate Configuration

```bash
terraform validate
```

### 3. Review Plan

```bash
terraform plan
```

### 4. Apply Infrastructure

```bash
terraform apply
```

Type `yes` when prompted.

---

## 🌐 Access Application

After deployment:

1. Open AWS Console → EC2 → Load Balancers
2. Copy ALB DNS Name
3. Open in browser:

```
http://<ALB-DNS>
```

You should see:

```
Hello from ASG <hostname>
```

---

## 📈 Auto Scaling

The Auto Scaling Group is configured with:

- Min instances: 1
- Max instances: 2
- Health checks via ALB
- Automatic instance replacement

Scaling policies can be extended if required.

---

## 🔐 Security

- EC2 instances run in private subnets
- ALB is publicly accessible
- Traffic is controlled via Security Groups
- SSH access via key pair

---

## 🧹 Destroy Infrastructure

To remove all resources:

```bash
terraform destroy
```

Confirm with `yes`.

---

## 💡 Best Practices Used

- Modular Terraform architecture
- Reusable infrastructure components
- Environment-based configuration
- Output-based module wiring
- No hardcoded values
- Clean separation of logic and config

---

## 📌 Future Enhancements

- Enable HTTPS using ACM
- Add CloudWatch monitoring
- Implement Blue/Green deployment
- Integrate CI/CD pipeline

---

## 👨‍💻 Author

Rajkumar Dubey  
DevOps / Cloud Engineer

---

## 📜 License

- This project is the replica of my Freelancing project how i have Implemented this Project.
- Free to use and modify.
