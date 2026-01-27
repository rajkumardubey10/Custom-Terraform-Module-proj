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
- Configure S3 remote backend
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
