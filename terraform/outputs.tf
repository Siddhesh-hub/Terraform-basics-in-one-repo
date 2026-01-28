# =============================================================================
# Output Values for Terraform Infrastructure
# =============================================================================
# Exports important resource values after infrastructure deployment.
#
# Purpose:
#   - Display critical information to users after terraform apply
#   - Enable integration with other systems via terraform output
#   - Provide quick access to resource identifiers and endpoints
#
# Common Uses:
#   - Getting EC2 public IPs for SSH access
#   - Extracting DNS names for application setup
#   - Feeding outputs to CI/CD pipelines or other tools
#   - Documenting infrastructure endpoints
#
# Accessing Outputs:
#   terraform output                        # Show all outputs
#   terraform output ec2_public_ip          # Show specific output
#   terraform output -json                  # Output as JSON
#
# =============================================================================

# EC2 Public IP Addresses
output "ec2_public_ip" {
  description = "Public IP addresses of EC2 instances for SSH access"
  value       = [for instance in aws_instance.my_instance : instance.public_ip]
}

# EC2 Public DNS Names
output "ec2_public_dns" {
  description = "Public DNS names of EC2 instances"
  value       = [for instance in aws_instance.my_instance : instance.public_dns]
}
