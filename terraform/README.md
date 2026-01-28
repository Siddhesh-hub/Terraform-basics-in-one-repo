# Basic AWS Infrastructure - Terraform Learning Project

## Overview

The `terraform` project demonstrates fundamental Terraform concepts through a practical AWS setup. It showcases how to build a complete networking layer with VPC, subnets, and compute resources, along with proper security configuration via security groups.

## 🎯 Purpose

This is an ideal learning project for understanding:
- ✅ VPC architecture with public and private subnets
- ✅ Security groups and network access control
- ✅ EC2 instance provisioning and management
- ✅ SSH key pair configuration
- ✅ User data scripts for instance initialization
- ✅ Remote state backend integration

## 📁 Project Structure

```
terraform/
├── vpc.tf                 # VPC configuration with public/private subnets
├── ec2.tf                 # EC2 instances, security groups, and key pairs
├── variables.tf           # Input variables
├── outputs.tf             # Output values
├── providers.tf           # AWS provider configuration
├── terraform.tf           # Terraform version and remote backend config
├── install_nginx.sh       # User data script for NGINX installation
├── tf_ec2_key             # Private SSH key (DO NOT COMMIT)
├── tf_ec2_key.pub         # Public SSH key
└── README.md              # This file
```

## 🏗️ AWS Resources Created

### 1. VPC Module (`vpc.tf`)
Uses the official AWS VPC module to create:
- **VPC CIDR:** 10.0.0.0/16
- **Availability Zones:** us-east-1a, us-east-1b
- **Public Subnets:** 10.0.101.0/24, 10.0.102.0/24
- **Private Subnets:** 10.0.1.0/24, 10.0.2.0/24
- **NAT Gateway:** For private subnet internet access
- **VPN Gateway:** For VPN connectivity (optional)

### 2. Security Group (`ec2.tf`)
Configured ports:
- **Port 22 (SSH):** SSH access from anywhere (0.0.0.0/0) - ⚠️ Restrict in production
- **Port 80 (HTTP):** HTTP web traffic
- **Port 443 (HTTPS):** HTTPS web traffic
- **Outbound:** All traffic allowed (0.0.0.0/0)

### 3. EC2 Instances (`ec2.tf`)
- **Instance Type:** Configurable (default: t3.micro)
- **AMI:** Amazon Linux 2
- **Key Pair:** SSH access via `tf_ec2_key`
- **User Data:** Automatic NGINX installation and startup

### 4. Key Pair (`ec2.tf`)
- **Public Key:** Stored in `tf_ec2_key.pub`
- **Private Key:** Stored locally as `tf_ec2_key` (never commit)
- **Purpose:** SSH access to EC2 instances

## 📋 File Descriptions

### `vpc.tf`
Defines the VPC module with network configuration. Creates a multi-AZ VPC with:
- Public subnets for web-facing resources
- Private subnets for database/backend resources
- NAT gateway for private subnet internet access
- Internet gateway for public subnet internet access

### `ec2.tf`
Manages EC2 instance deployment including:
- SSH key pair creation
- Security group with ingress/egress rules
- Default VPC and security group configuration
- EC2 instance launch configuration

### `variables.tf`
Defines input variables:
- `env` - Environment name (dev, staging, prod)
- `instance_type` - EC2 instance type
- `instance_count` - Number of instances to create

### `outputs.tf`
Exports important values after deployment:
- Instance public IPs
- Security group ID
- VPC details

### `install_nginx.sh`
User data script that:
- Updates system packages
- Installs NGINX
- Starts NGINX service
- Creates a sample web page

### `providers.tf`
Configures the AWS provider with region and credentials

### `terraform.tf`
Specifies Terraform version requirements (AWS provider ~> 6.0) and backend configuration

## 🚀 Deployment Instructions

### Prerequisites
- Terraform installed (v1.0+)
- AWS CLI configured with credentials
- AWS account with EC2, VPC, and networking permissions

### Step 1: Initialize Terraform
```bash
cd terraform
terraform init
```

### Step 2: Create SSH Keys
If SSH keys don't exist:
```bash
ssh-keygen -t rsa -b 4096 -f tf_ec2_key -N ""
```

### Step 3: Create terraform.tfvars
```bash
cat > terraform.tfvars << EOF
env             = "dev"
instance_type   = "t3.micro"
instance_count  = 1
EOF
```

### Step 4: Validate Configuration
```bash
terraform validate
```

### Step 5: Review Planned Changes
```bash
terraform plan -var-file="terraform.tfvars"
```

### Step 6: Apply Configuration
```bash
terraform apply -var-file="terraform.tfvars"
```

## 🌐 Accessing Your Instances

### Get Instance Details
```bash
terraform output instance_public_ips
```

### SSH into Instance
```bash
ssh -i tf_ec2_key -u ec2-user <PUBLIC_IP>
```

### Access NGINX
```bash
# Via SSH
curl http://<PUBLIC_IP>

# Via Browser
http://<PUBLIC_IP>
```

## 🔧 Configuration Variables

| Variable | Type | Default | Description |
|----------|------|---------|-------------|
| `env` | string | "dev" | Environment name |
| `instance_type` | string | "t3.micro" | EC2 instance type |
| `instance_count` | number | 1 | Number of instances |
| `region` | string | "us-east-1" | AWS region |

## 📊 Network Architecture

```
┌─────────────────────────────────────┐
│         VPC (10.0.0.0/16)           │
├─────────────────────────────────────┤
│                                     │
│  ┌──────────────────────────────┐  │
│  │   Internet Gateway           │  │
│  └──────────────┬───────────────┘  │
│                 │                  │
│  ┌──────────────┴────────────────┐ │
│  │     Public Subnets           │ │
│  │  10.0.101.0/24 (AZ-1a)      │ │
│  │  10.0.102.0/24 (AZ-1b)      │ │
│  │                              │ │
│  │  [EC2 with NGINX]            │ │
│  └──────────────────────────────┘ │
│                                     │
│  ┌──────────────────────────────┐  │
│  │   NAT Gateway                │  │
│  └──────────────┬───────────────┘  │
│                 │                  │
│  ┌──────────────┴────────────────┐ │
│  │    Private Subnets           │ │
│  │  10.0.1.0/24 (AZ-1a)        │ │
│  │  10.0.2.0/24 (AZ-1b)        │ │
│  └──────────────────────────────┘ │
│                                     │
└─────────────────────────────────────┘
```

## 🔐 Security Best Practices

✅ **Implemented:**
- Security group with restricted ingress rules
- SSH key pair authentication
- Default VPC configuration

⚠️ **For Production:**
- Restrict SSH access to specific IPs (not 0.0.0.0/0)
- Use AWS Systems Manager Session Manager instead of SSH
- Enable VPC Flow Logs
- Use AWS Secrets Manager for key management
- Enable CloudTrail for audit logging
- Use private subnets for instances with Bastion host

## 🧹 Cleanup

To destroy all resources:
```bash
terraform destroy -var-file="terraform.tfvars"
```

⚠️ **Note:** Destroying removes all EC2 instances, VPC, and networking resources.

## 📈 Learning Extensions

Try these modifications to deepen your learning:
1. Add RDS database in private subnet
2. Create Application Load Balancer (ALB)
3. Implement Auto Scaling Group
4. Add CloudWatch monitoring
5. Configure Route53 for DNS
6. Enable VPC Flow Logs

## 🔗 Related Projects

- [remote_infra](../remote_infra/) - Backend setup for state management
- [terraform-modules-app](../terraform-modules-app/) - Advanced modularized infrastructure

## 📚 Additional Resources

- [Terraform AWS VPC Module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest)
- [AWS VPC Documentation](https://docs.aws.amazon.com/vpc/)
- [EC2 User Data Scripts](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html)
- [Terraform Variable Documentation](https://www.terraform.io/language/values/variables)

---

**Project Type:** Learning / Infrastructure Foundation  
**Difficulty Level:** Beginner to Intermediate  
**AWS Services:** VPC, EC2, Security Groups, Key Pairs  
**Estimated Cost:** Free tier eligible (t3.micro)
