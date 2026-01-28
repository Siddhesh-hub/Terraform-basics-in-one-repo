# =============================================================================
# DynamoDB Table for Terraform State Locking
# =============================================================================
# Creates a DynamoDB table to manage Terraform state locks, preventing
# concurrent modifications that could corrupt infrastructure state.
#
# Resource: aws_dynamodb_table.basic-dynamodb-table
#
# Purpose:
#   - Implement distributed locking mechanism
#   - Prevent simultaneous terraform apply operations
#   - Ensure consistency in collaborative environments
#   - Track state locks with LockID
#
# Table Configuration:
#   - Name: tf_remote_infra_state_table
#   - Hash Key: LockID (String) - Unique lock identifier
#   - Billing Mode: PAY_PER_REQUEST (pay per request, no provisioning)
#   - Region: us-east-1 (via provider)
#
# How State Locking Works:
#   1. When 'terraform apply' starts, a lock is acquired
#   2. Lock details stored in DynamoDB with LockID
#   3. Other apply operations wait for lock release
#   4. Lock released when apply completes (success or error)
#   5. Prevents state corruption from concurrent operations
#
# Billing:
#   - PAY_PER_REQUEST: Cost based on read/write usage
#   - Better for unpredictable/low-frequency operations
#   - Eliminates need for capacity planning
#
# Troubleshooting:
#   - If process crashes, lock may persist
#   - Manual unlock: terraform force-unlock <LOCK_ID>
#   - View locks: AWS Console > DynamoDB > Tables > Items
# =============================================================================

resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "tf_remote_demo_infra_state_table"
  billing_mode   = "PAY_PER_REQUEST"  # Pay per request pricing
  hash_key       = "LockID"           # Primary key for lock entries

  # Define the LockID attribute for lock tracking
  attribute {
    name = "LockID"
    type = "S"  # String type for unique lock identifier
  }

  tags = {
    Name        = "tf_remote_demo_infra_state_table"  
    Project     = "terraform-learning"
    Purpose     = "state-locking"
  }
}