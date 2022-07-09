provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAQ6OEQFVNRZMCRFBA"
  secret_key = "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"
}
resource "aws_instance" "web_instances_plus1" {
  ami           = "ami-0533f2ba8a1995cf9"
  instance_type = "t2.micro"
}
resource "aws_instance" "web_instances_plus12" {
  ami           = "ami-0533f2ba8a1995cf9"
  instance_type = "t2.micro"
}
