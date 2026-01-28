# =============================================================================
# VPC Module Configuration
# =============================================================================
# Creates a Virtual Private Cloud (VPC) with public and private subnets
# across multiple availability zones using the official AWS VPC module.
#
# Resource: module.vpc (terraform-aws-modules/vpc/aws)
#
# Purpose:
#   - Establish isolated network environment in AWS
#   - Create multi-AZ infrastructure for high availability
#   - Separate public-facing and private resources
#   - Enable secure communication between resources
#
# VPC Configuration:
#   - CIDR Block: 10.0.0.0/16 (65,536 addresses)
#   - Availability Zones: us-east-1a, us-east-1b (2 AZs)
#   - Public Subnets: 10.0.101.0/24, 10.0.102.0/24 (256 addresses each)
#   - Private Subnets: 10.0.1.0/24, 10.0.2.0/24 (256 addresses each)
#
# Network Components Created:
#   - Internet Gateway: Enables public subnet internet access
#   - NAT Gateway: Allows private subnet outbound internet access
#   - Route Tables: Control traffic flow for public/private subnets
#   - Elastic IPs: Static IP for NAT Gateway
#
# =============================================================================

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "sid-first-vpc-${var.env}"
  cidr = "10.0.0.0/16"  # 65,536 total addresses

  # Availability zones for multi-AZ deployment
  azs             = ["us-east-1a", "us-east-1b"]
  
  # Private subnets (no direct internet access)
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  
  # Public subnets (internet-accessible)
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  # Enable NAT Gateway for private subnet internet access
  enable_nat_gateway = true
  
  # Enable VPN Gateway for site-to-site VPN connectivity
  enable_vpn_gateway = true

  tags = {
    Terraform   = "true"
    Project     = "terraform-learning"
    Environment = var.env
  }
}