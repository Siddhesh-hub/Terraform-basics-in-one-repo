module "dev-infra" {
  source               = "./infra-app"
  env                  = "dev"
  bucket_name          = "demo-infra-app-bucket"
  instance_count       = 2
  instance_type        = "t3.micro"
  ec2_ami_id           = "ami-0b6c6ebed2801a5cb"
  ec2_root_volume_size = 8
  dynamodb_table_name  = "tf_remote_infra_state_table"
  dynanodb_hash_key    = "LockID"
}

module "beta-infra" {
  source               = "./infra-app"
  env                  = "beta"
  bucket_name          = "demo-infra-app-bucket"
  instance_count       = 1
  instance_type        = "t3.micro"
  ec2_ami_id           = "ami-0b6c6ebed2801a5cb"
  ec2_root_volume_size = 8
  dynamodb_table_name  = "tf_remote_infra_state_table"
  dynanodb_hash_key    = "LockID"
}

module "prod-infra" {
  source               = "./infra-app"
  env                  = "prod"
  bucket_name          = "demo-infra-app-bucket"
  instance_count       = 2
  instance_type        = "t3.micro"
  ec2_ami_id           = "ami-0b6c6ebed2801a5cb"
  ec2_root_volume_size = 8
  dynamodb_table_name  = "tf_remote_infra_state_table"
  dynanodb_hash_key    = "LockID"
}