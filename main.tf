provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAQ6OEQFVN3CJ4BLM5"
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
