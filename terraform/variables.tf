# =============================================================================
# Input Variables for Terraform EC2 Infrastructure
# =============================================================================
# Defines configurable variables for the EC2 instance deployment.
#
# Purpose:
#   - Allow flexible configuration without modifying main code
#   - Support multiple environments (dev, staging, prod)
#   - Enable instance customization (type, size, AMI)
#
# Variables can be provided via:
#   1. terraform.tfvars file (highest priority for file-based)
#   2. Command line: terraform apply -var="env=prod"
#   3. Environment variables: TF_VAR_env="prod"
#   4. Default values in variable definition
#
# =============================================================================

# EC2 Instance Type Variable
variable "ec2_instance_type" {
  default     = "t3.micro"  # Free tier eligible
  type        = string
  description = "Type of EC2 instance to launch (e.g., t3.micro, t3.small)"
}

# EC2 AMI ID Variable
variable "ec2_ami_id" {
  default     = "ami-0ecb62995f68bb549"  # Amazon Linux 2 AMI (us-east-1)
  type        = string
  description = "AMI ID for the EC2 instance. Default: Amazon Linux 2"
}

# EC2 Root Volume Size Variable
variable "ec2_root_volume_size" {
  default     = 8  # GB - Free tier eligible
  type        = number
  description = "Root volume size in GB for the EC2 instance"
}

# Environment Variable
variable "env" {
  default     = "dev"
  type        = string
  description = "Environment name (dev, staging, prod) - used for resource naming"
}