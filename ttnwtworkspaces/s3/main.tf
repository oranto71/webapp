resource "aws_s3_bucket" "ttnwt_s3_bucket" {
    bucket = "ttnwt-bucket" 
    acl = "private"
}