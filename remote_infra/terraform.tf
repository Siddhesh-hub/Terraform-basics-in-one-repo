# =============================================================================
# Terraform Configuration for Remote State Backend
# =============================================================================
# This file configures Terraform version requirements and specifies the AWS
# provider version needed for this remote infrastructure project.
#
# Purpose:
#   - Define minimum Terraform version requirements
#   - Specify AWS provider version compatibility
#   - Ensure consistent provider behavior across environments
# =============================================================================

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.28.0"  # Pin to specific version for stability
    }
  }
  # Note: Backend configuration for this project uses local state
  # Other projects will use this as their backend
}