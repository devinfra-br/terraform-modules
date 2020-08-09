resource "aws_s3_bucket" "bucket-curso" {
  bucket = var.bucket-name
  acl    = "private"
}