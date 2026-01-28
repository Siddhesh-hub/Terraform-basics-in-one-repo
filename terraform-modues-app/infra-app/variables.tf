variable "env" {
    description = "The environment for the resources"
    type        = string
}

variable "bucket_name" {
    description = "The name of the S3 bucket"
    type        = string
}

variable "instance_count" {
    description = "Number of EC2 instances to create"
    type        = number
}

variable "instance_type" {
    description = "Type of EC2 instance"
    type        = string
}

variable "ec2_ami_id" {
    description = "AMI ID for the EC2 instance"
    type        = string
}

variable "ec2_root_volume_size" {
    description = "Root volume size for the EC2 instance in GB"
    type        = number
}

variable "dynamodb_table_name" {
    description = "Name of the DynamoDB table"
    type        = string
}

variable "dynanodb_hash_key" {
    description = "Hash key for the DynamoDB table"
    type        = string
}