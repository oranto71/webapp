provider "aws" {
  region     = "us-east-1"
}
data "aws_availability_zones" "available" {
		  state = "available"
		}
resource "aws_vpc" "VPC" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
}
resource "aws_subnet" "PublicSubnet1" {
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = false
  vpc_id = aws_vpc.VPC.id
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "Public Subnet AZ A"
  }
}
resource "aws_subnet" "PublicSubnet2" {
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = false
  vpc_id = aws_vpc.VPC.id
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "Public Subnet AZ B"
  }
}

resource "aws_subnet" "PrivateSubnet1" {
  cidr_block = "10.0.10.0/24"
  map_public_ip_on_launch = false
  vpc_id = aws_vpc.VPC.id
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "Private Subnet AZ A"
  }
}

resource "aws_subnet" "PrivateSubnet2" {
