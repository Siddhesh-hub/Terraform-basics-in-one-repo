# =============================================================================
# AWS Provider Configuration
# =============================================================================
# Configures the AWS provider with region and authentication settings.
#
# Purpose:
#   - Authenticate Terraform to AWS
#   - Set default AWS region for resources
#   - Enable AWS API operations
#
# Region: us-east-1 (N. Virginia)
#   - Primary AWS region for this learning project
#   - Contains all AWS services
#   - Lower latency for US-based users
#
# Credentials (in order of precedence):
#   1. Environment variables: AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY
#   2. AWS credentials file: ~/.aws/credentials
#   3. IAM role (if running on EC2, Lambda, ECS)
#   4. AWS SSO configuration
#
# Best Practices:
#   - Never hardcode credentials in Terraform files
#   - Use IAM roles when possible (EC2, ECS, Lambda)
#   - Use AWS SSO for team access
#   - Rotate credentials regularly
# =============================================================================

provider "aws" {
  region = "us-east-1"  # N. Virginia region
}