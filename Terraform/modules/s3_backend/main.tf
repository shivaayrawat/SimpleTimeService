resource "aws_s3_bucket" "terraform_backend" {
  bucket = var.s3_bucket_name
  acl    = "private"
}
