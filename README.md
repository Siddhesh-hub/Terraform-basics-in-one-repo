# Terraform Learning Projects

A comprehensive collection of Terraform learning projects demonstrating Infrastructure-as-Code (IaC) best practices on AWS. This repository contains three interconnected projects showcasing different levels of Terraform complexity, from basic infrastructure setup to modularized multi-environment deployments.

## 📚 Project Overview

This repository is designed as a learning resource for understanding Terraform workflows, remote state management, and AWS infrastructure provisioning. All projects are currently set up for learning purposes and can be expanded for production use.

### Repository Structure

```
tf/
├── remote_infra/              # Remote state management backend
├── terraform/                 # Basic AWS infrastructure with VPC and EC2
├── terraform-modules-app/     # Modularized multi-environment deployment
└── README.md                  # This file
```

## 🏗️ Projects

### 1. **remote_infra** - Remote State Backend
This project sets up the foundation for remote state management, enabling safe and collaborative Terraform workflows.

**Key Components:**
- S3 bucket for storing Terraform state files
- DynamoDB table for state locking (prevents concurrent modifications)
- Backend configuration for centralized state management

**Use Case:** Foundation for all other projects to maintain consistent state across environments.

[👉 Read remote_infra Documentation](./remote_infra/README.md)

---

### 2. **terraform** - Basic AWS Infrastructure
Demonstrates fundamental Terraform concepts with a practical AWS setup including networking and compute resources.

**Key Components:**
- VPC with public and private subnets across multiple availability zones
- EC2 instances with security group configuration
- SSH access and HTTP/HTTPS ports
- NGINX server installation via user data script

**Use Case:** Foundation project for learning VPC architecture, security groups, and EC2 instance management.

[👉 Read terraform Documentation](./terraform/README.md)

---

### 3. **terraform-modules-app** - Modularized Infrastructure
Shows how to use Terraform modules to create reusable, maintainable infrastructure code across multiple environments (dev, beta, prod).

**Key Components:**
- Custom module `infra-app` for creating environments
- Multi-environment deployments with variable inputs
- EC2 instances with environment-specific configurations
- S3 and DynamoDB integration

**Use Case:** Demonstrates module best practices and multi-environment deployments.

[👉 Read terraform-modules-app Documentation](./terraform-modules-app/README.md)

---

## 🚀 Quick Start Guide

### Prerequisites
- [Terraform](https://www.terraform.io/downloads.html) (v1.0 or later)
- [AWS CLI](https://aws.amazon.com/cli/) configured with valid credentials
- AWS account with appropriate permissions

### Step 1: Set Up Remote State Backend (First Time Only)

```bash
cd remote_infra
terraform init
terraform plan
terraform apply
```

This creates the S3 bucket and DynamoDB table needed for remote state.

### Step 2: Deploy Basic Infrastructure

```bash
cd ../terraform
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

### Step 3: Deploy Modularized Application Infrastructure

```bash
cd ../terraform-modules-app
terraform init
terraform plan
terraform apply
```

## 📖 Learning Path

1. **Start with `remote_infra`** - Understand state management and backend configuration
2. **Move to `terraform`** - Learn basic AWS resources (VPC, EC2, security groups)
3. **Study `terraform-modules-app`** - Understand modules, variables, and multi-environment setups

## 🔧 Configuration

Each project uses `terraform.tfvars` for environment-specific variables. Example template:

```hcl
env = "dev"
region = "us-east-1"
```

## 📋 Key AWS Resources

| Resource | Projects | Purpose |
|----------|----------|---------|
| S3 Bucket | remote_infra, terraform-modules-app | State storage & application data |
| DynamoDB Table | remote_infra | State locking |
| VPC | terraform | Network isolation |
| EC2 Instances | terraform, terraform-modules-app | Compute resources |
| Security Groups | terraform, terraform-modules-app | Network access control |
| Key Pairs | terraform, terraform-modules-app | SSH access |

## 🛡️ Security Best Practices Demonstrated

- ✅ Remote state management with locking
- ✅ Security groups with restricted access
- ✅ SSH key pair management
- ✅ Environment-based resource separation
- ✅ Variables and outputs for sensitive data handling

## 📝 Common Terraform Commands

```bash
# Initialize Terraform working directory
terraform init

# Validate configuration syntax
terraform validate

# Preview changes
terraform plan

# Apply changes
terraform apply

# Show current state
terraform show

# Destroy all resources
terraform destroy
```

## 🗑️ Cleanup

To destroy all infrastructure and avoid AWS charges:

```bash
# Destroy modules-app infrastructure
cd terraform-modules-app
terraform destroy

# Destroy basic infrastructure
cd ../terraform
terraform destroy

# Finally, destroy remote state backend
cd ../remote_infra
terraform destroy
```

## 📌 Important Notes

- **AWS Costs:** All projects use free-tier eligible resources (t3.micro instances), but charges may still apply
- **State Files:** Never commit `terraform.tfstate` files to version control; they are already in `.gitignore`
- **Credentials:** Ensure AWS credentials are configured via `~/.aws/credentials` or environment variables
- **Region:** Default region is `us-east-1`; modify in `providers.tf` for other regions

## 🤝 Contributing & Learning

This is a learning repository. Feel free to:
- Experiment with additional resources
- Modify variable values to understand behavior
- Add new modules or environments
- Document your learnings in commit messages

## 📚 Additional Resources

- [Terraform Official Documentation](https://www.terraform.io/docs)
- [AWS Terraform Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Terraform Best Practices](https://www.terraform.io/docs/language/settings/index.html)
- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)

## 📄 License

This learning repository is provided as-is for educational purposes.

---

**Last Updated:** January 2026  
**Purpose:** Terraform Learning & AWS Infrastructure Practice
