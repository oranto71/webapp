resource "aws_instance" "web_instances_plus" {
  ami           = "ami-0533f2ba8a1995cf9"
  instance_type = lookup(var.instance_type,terraform.workspace)
}
resource "aws_s3_bucket" "ttnwt-bucket-school" {
    bucket = "ttnwt-bucket-school" 
    acl = "private"
}
resource "aws_instance" "web_instances_plus1" {
  ami           = "ami-0533f2ba8a1995cf9"
  instance_type = "t2.micro"
}
resource "aws_instance" "web_instances_plus12" {
  ami           = "ami-0533f2ba8a1995cf9"
  instance_type = "t2.micro"
}