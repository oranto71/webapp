terraform {  #block call terraform
  backend "s3" {
    bucket = "ttnwt-bucket-school"
    key = "ec2/ec2.tfstate"  #just the path and the file name for your tfstate
    region = "us-east-1"
    access_key = "AKIAQ6OEQFVNRZMCRFBA"
    secret_key = "W87u6NcSOZCmVByVJO2Zfsb6TTh3TV1WjEZX+cYm"
    dynamodb_table = "terraform-state-lock-dynamo-tt_school"
  }
}
resource "aws_dynamodb_table" "my_first_table_school" {
  name        = "terraform-state-lock-dynamo-tt_school"
  hash_key       = "LockID"
  read_capacity = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }
}