resource "aws_dynamodb_table" "infra-app-dynamodb-table" {
  name           = "${var.env}-${var.dynamodb_table_name}"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "${var.dynanodb_hash_key}"

  attribute {
    name = var.dynanodb_hash_key
    type = "S"
  }

  tags = {
    Name        = "${var.env}-${var.dynamodb_table_name}"  
    Environment = var.env
  }
}