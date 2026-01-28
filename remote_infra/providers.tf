# =============================================================================
# AWS Provider Configuration for Remote Infrastructure
# =============================================================================
# Configures the AWS provider to use the us-east-1 region.
#
# Purpose:
#   - Authenticate and interact with AWS services
#   - Set the primary region for all resources
#   - Establish connection to AWS API
#
# Region: us-east-1 (N. Virginia)
#   - First AWS region launched
#   - Contains all AWS service offerings
#   - Good for US-based applications
#
# Credentials:
#   - AWS CLI configured credentials will be used automatically
#   - Environment variables: AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY
#   - IAM roles (when running on EC2 or Lambda)
# =============================================================================

provider "aws" {
  region = "us-east-1"
}