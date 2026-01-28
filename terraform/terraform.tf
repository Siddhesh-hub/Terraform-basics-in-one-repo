# =============================================================================
# Terraform Configuration with Remote State Backend
# =============================================================================
# Configures Terraform version requirements and remote state management.
#
# Purpose:
#   - Specify AWS provider version compatibility
#   - Configure S3 remote backend for state storage
#   - Enable state locking via DynamoDB
#   - Support collaborative infrastructure management
#
# Backend Configuration:
#   - Bucket: remote-infra-bucket-479384738202 (created by remote_infra project)
#   - Key: terraform.tfstate (state file path in bucket)
#   - Region: us-east-1
#   - DynamoDB Table: tf_remote_infra_state_table (state locking)
#
# How Remote Backend Works:
#   1. Terraform reads/writes state to S3 instead of local file
#   2. Before modifications, acquires lock from DynamoDB
#   3. Lock prevents concurrent terraform apply operations
#   4. Enables safe team collaboration on infrastructure
#   5. S3 versioning provides automatic backups
#
# =============================================================================

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"  # Accept patch and minor version updates
    }
  }

  # Remote backend for state management
  backend "s3" {
    bucket         = "remote-infra-bucket"  # S3 bucket for state
    key            = "terraform.tfstate"                  # State file path
    region         = "us-east-1"                          # AWS region
    dynamodb_table = "tf_remote_infra_state_table"        # DynamoDB for locking
  }
}