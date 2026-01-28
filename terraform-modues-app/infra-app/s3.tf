resource "aws_s3_bucket" "infra-app-s3-bucket" {
    bucket = "${var.env}-${var.bucket_name}"

    tags = {
        Name = "${var.env}-${var.bucket_name}"
        Environment = var.env
    }
}