provider "aws" {
  region     = "us-east-1"
}
resource "aws_instance" "web_instances_plus1" {
  ami           = "ami-0533f2ba8a1995cf9"
  instance_type = "t2.micro"
}
resource "aws_instance" "web_instances_plus12" {
  ami           = "ami-0533f2ba8a1995cf9"
  instance_type = "t2.micro"
}
