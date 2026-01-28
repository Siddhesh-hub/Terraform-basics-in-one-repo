# Terraform Modules App - Multi-Environment Infrastructure

## Overview

The `terraform-modules-app` project demonstrates advanced Terraform patterns through a reusable module-based architecture. It showcases how to create multiple environments (dev, beta, prod) from a single module definition, enabling consistent infrastructure across environments with minimal code duplication.

## 🎯 Purpose

This project teaches critical Terraform skills:
- ✅ **Module Creation & Reusability:** Build custom modules for infrastructure patterns
- ✅ **Multi-Environment Deployments:** Deploy consistent infrastructure across dev/beta/prod
- ✅ **Variable Management:** Use variables to customize behavior per environment
- ✅ **Infrastructure as Code:** Maintain infrastructure consistency through code
- ✅ **Scalability:** Add new environments with minimal changes
- ✅ **Maintainability:** Update infrastructure in one place, apply everywhere

## 📁 Project Structure

```
terraform-modules-app/
├── main.tf                   # Module instantiation for all environments
├── providers.tf              # AWS provider configuration
├── terraform.tf              # Terraform version and backend config
├── infra_app_key.pub         # Public SSH key
├── infra-app/                # Custom reusable module
│   ├── ec2.tf               # EC2 instances and security groups
│   ├── s3.tf                # S3 buckets for application data
│   ├── dynamodb.tf          # DynamoDB tables for application state
│   └── variables.tf         # Module input variables
└── README.md                # This file
```

## 🏗️ Architecture Overview

### Module: `infra-app`
A reusable infrastructure module that creates:
- **EC2 Instances** - Multiple instances per environment
- **Security Groups** - Access control for ports 22, 80, 8000
- **S3 Bucket** - Application data storage
- **DynamoDB Table** - Application state management
- **SSH Key Pair** - Instance access

### Environments Deployed
Three identical infrastructure stacks with environment-specific configurations:

1. **dev** - 2 EC2 instances, for development and testing
2. **beta** - 1 EC2 instance, for staging and validation
3. **prod** - 2 EC2 instances, for production deployment

## 📋 File Descriptions

### `main.tf`
Instantiates the `infra-app` module three times with environment-specific variables:

```hcl
module "dev-infra" {
  source = "./infra-app"
  env = "dev"
  instance_count = 2
  # ... other variables
}

module "beta-infra" {
  source = "./infra-app"
  env = "beta"
  instance_count = 1
  # ... other variables
}

module "prod-infra" {
  source = "./infra-app"
  env = "prod"
  instance_count = 2
  # ... other variables
}
```

### Module Files (`infra-app/`)

#### `variables.tf`
Defines module input variables:
- `env` - Environment name (dev, beta, prod)
- `bucket_name` - S3 bucket name
- `instance_count` - Number of EC2 instances
- `instance_type` - EC2 instance type (t3.micro, t3.small, etc.)
- `ec2_ami_id` - AMI ID for instances
- `ec2_root_volume_size` - Root disk size in GB
- `dynamodb_table_name` - DynamoDB table name
- `dynamodb_hash_key` - DynamoDB hash key

#### `ec2.tf`
Creates EC2 infrastructure:
- SSH key pair with environment-specific naming
- Security group with rules for:
  - SSH (port 22) for administration
  - HTTP (port 80) for web traffic
  - Custom port 8000 for Flask/application server
- Default VPC configuration
- EC2 instance launch configuration

#### `s3.tf`
Creates S3 buckets for:
- Application data storage
- Environment-specific organization
- Potential backup storage

#### `dynamodb.tf`
Creates DynamoDB tables for:
- Application state management
- Session storage
- Database-like functionality

## 🚀 Deployment Instructions

### Prerequisites
- Terraform installed (v1.0+)
- AWS CLI configured with credentials
- AWS account with EC2, VPC, S3, and DynamoDB permissions

### Step 1: Initialize Terraform
```bash
cd terraform-modules-app
terraform init
```

### Step 2: Validate Configuration
```bash
terraform validate
```

### Step 3: Review Planned Changes
```bash
terraform plan
```

This will show all resources to be created for all three environments.

### Step 4: Apply Configuration
```bash
terraform apply
```

When prompted, type `yes` to confirm resource creation.

## 📊 Module Structure Diagram

```
┌─────────────────────────────────────────────────────┐
│          main.tf (Module Orchestration)             │
├─────────────────────────────────────────────────────┤
│                                                     │
│  ┌────────────────────────────────────────────┐   │
│  │ module "dev-infra"                         │   │
│  │   env = "dev"                              │   │
│  │   instance_count = 2                       │   │
│  └────────────────────────────────────────────┘   │
│                    ↓                               │
│  ┌────────────────────────────────────────────┐   │
│  │ module "beta-infra"                        │   │
│  │   env = "beta"                             │   │
│  │   instance_count = 1                       │   │
│  └────────────────────────────────────────────┘   │
│                    ↓                               │
│  ┌────────────────────────────────────────────┐   │
│  │ module "prod-infra"                        │   │
│  │   env = "prod"                             │   │
│  │   instance_count = 2                       │   │
│  └────────────────────────────────────────────┘   │
│                                                     │
│              ↓ All call                             │
│                                                     │
│  ┌───────────────────────────────────────────┐    │
│  │     infra-app/ (Reusable Module)          │    │
│  │  ┌─────────────────────────────────────┐ │    │
│  │  │ EC2 Instances                       │ │    │
│  │  │ Security Groups                     │ │    │
│  │  │ SSH Key Pairs                       │ │    │
│  │  └─────────────────────────────────────┘ │    │
│  │  ┌─────────────────────────────────────┐ │    │
│  │  │ S3 Buckets                          │ │    │
│  │  │ DynamoDB Tables                     │ │    │
│  │  └─────────────────────────────────────┘ │    │
│  └───────────────────────────────────────────┘    │
│                                                     │
└─────────────────────────────────────────────────────┘
```

## 🔧 Module Variables Reference

### Required Variables
```hcl
env              # Environment name: "dev", "beta", or "prod"
bucket_name      # S3 bucket name
instance_count   # Number of EC2 instances to create
instance_type    # EC2 instance type (e.g., "t3.micro")
ec2_ami_id       # AMI ID (e.g., "ami-0b6c6ebed2801a5cb")
ec2_root_volume_size  # Root volume size in GB
dynamodb_table_name   # DynamoDB table name
dynamodb_hash_key     # Hash key for DynamoDB (e.g., "LockID")
```

## 🌐 Multi-Environment Management

### Environment-Specific Configurations

| Aspect | Dev | Beta | Prod |
|--------|-----|------|------|
| **Instance Count** | 2 | 1 | 2 |
| **Instance Type** | t3.micro | t3.micro | t3.micro |
| **Root Volume** | 8 GB | 8 GB | 8 GB |
| **Purpose** | Testing & Dev | Staging | Live Traffic |
| **Downtime Impact** | Low | Medium | Critical |

### Modifying Environment Configurations

Edit `main.tf` to change any environment:
```hcl
module "prod-infra" {
  source               = "./infra-app"
  env                  = "prod"
  instance_count       = 3              # Increase instances
  instance_type        = "t3.small"     # Upgrade instance type
  ec2_root_volume_size = 16             # Increase disk
  # ... other variables
}
```

Then apply:
```bash
terraform plan
terraform apply
```

## 🏆 Key Benefits of Module-Based Architecture

| Benefit | Description |
|---------|-------------|
| **DRY (Don't Repeat Yourself)** | Define infrastructure once, use in multiple places |
| **Consistency** | Same configuration across environments |
| **Maintainability** | Update in module, reflects everywhere |
| **Scalability** | Easy to add new environments |
| **Reusability** | Module can be used in other projects |
| **Testing** | Test module once, all environments benefit |

## 🔐 Security Best Practices

✅ **Implemented:**
- Environment-specific resource naming
- Security groups with restricted access
- Environment separation via modules

⚠️ **For Production:**
- Use separate AWS accounts per environment
- Implement network segmentation with VPCs
- Enable AWS Organizations for multi-account management
- Use AWS Secrets Manager for sensitive data
- Enable CloudTrail and VPC Flow Logs
- Restrict SSH access to specific IPs

## 📈 Learning Exercises

Try these to enhance your understanding:

1. **Add a 4th Environment:** Create a "staging" environment
2. **Add RDS Database:** Extend the module to include RDS
3. **Add Monitoring:** Integrate CloudWatch dashboards
4. **Parameter Store:** Store environment configs in SSM Parameter Store
5. **Outputs:** Add module outputs and use them in main.tf
6. **Locals:** Use locals for common values (environment prefixes)

## 🧹 Cleanup

To destroy all infrastructure:
```bash
terraform destroy
```

This will remove all resources from all three environments.

To destroy specific environment:
```bash
terraform destroy -target=module.dev-infra
terraform destroy -target=module.beta-infra
terraform destroy -target=module.prod-infra
```

## 📝 Module Best Practices Demonstrated

✅ Clear variable definitions  
✅ Environment-based resource naming  
✅ Consistent tagging strategy  
✅ Modular resource organization  
✅ Separation of concerns  
✅ Reusability across environments  

## 🔗 Related Projects

- [remote_infra](../remote_infra/) - Backend setup for state management
- [terraform](../terraform/) - Basic infrastructure foundation

## 📚 Additional Resources

- [Terraform Modules Documentation](https://www.terraform.io/language/modules)
- [Module Best Practices](https://www.terraform.io/language/modules/develop)
- [Registry Modules](https://registry.terraform.io/)
- [Module Composition Patterns](https://www.terraform.io/language/modules/develop/composition)

## 💡 Real-World Applications

This module pattern is ideal for:
- **Multi-tenant SaaS:** One module per customer/tenant
- **Blue-Green Deployments:** Dev/Beta/Prod pattern
- **Regional Deployments:** Module per region
- **Microservices:** Module per service
- **Team Shared Infrastructure:** Centralized module library

---

**Project Type:** Advanced Learning / Production Pattern  
**Difficulty Level:** Intermediate to Advanced  
**AWS Services:** EC2, VPC, S3, DynamoDB, Security Groups  
**Estimated Cost:** Free tier eligible  
**Learning Focus:** Modules, Reusability, Multi-Environment Patterns
