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
  cidr_block = "10.0.11.0/24"
  map_public_ip_on_launch = false
  vpc_id = aws_vpc.VPC.id
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "Private Subnet AZ B"
  }
}
resource "aws_route_table" "RouteTablePublic" {
  vpc_id = aws_vpc.VPC.id
  depends_on = [ aws_internet_gateway.Igw ]

  tags = {
    Name = "Public Route Table"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Igw.id
  }
}

resource "aws_route_table_association" "AssociationForRouteTablePublic0" {
  subnet_id = aws_subnet.PublicSubnet1.id
  route_table_id = aws_route_table.RouteTablePublic.id
}

resource "aws_route_table_association" "AssociationForRouteTablePublic1" {
  subnet_id = aws_subnet.PublicSubnet2.id
  route_table_id = aws_route_table.RouteTablePublic.id
}



resource "aws_route_table" "RouteTablePrivate1" {
  vpc_id = aws_vpc.VPC.id
  depends_on = [ aws_nat_gateway.NatGw1 ]

  tags = {
    Name = "Private Route Table A"
  }

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NatGw1.id
  }
}

resource "aws_route_table_association" "AssociationForRouteTablePrivate10" {
  subnet_id = aws_subnet.PrivateSubnet1.id
  route_table_id = aws_route_table.RouteTablePrivate1.id
}



resource "aws_route_table" "RouteTablePrivate2" {
  vpc_id = aws_vpc.VPC.id
  depends_on = [ aws_nat_gateway.NatGw1 ]

  tags = {
    Name = "Private Route Table B"
  }

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NatGw1.id
  }
}

resource "aws_route_table_association" "AssociationForRouteTablePrivate20" {
  subnet_id = aws_subnet.PrivateSubnet2.id
  route_table_id = aws_route_table.RouteTablePrivate2.id
}



resource "aws_internet_gateway" "Igw" {
  vpc_id = aws_vpc.VPC.id
}

resource "aws_eip" "EipForNatGw1" {
}

resource "aws_nat_gateway" "NatGw1" {
  allocation_id = aws_eip.EipForNatGw1.id
  subnet_id = aws_subnet.PublicSubnet1.id

  tags = {
    Name = "NAT GW A"
  }
}
resource "aws_security_group" "sg_web" {
    name = "sg_web"
    vpc_id = aws_vpc.VPC.id

    dynamic "ingress" {
       for_each =  var.security_group
       content {
        from_port = ingress.value
        to_port = ingress.value
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
       }
    }
    egress   {
      cidr_blocks = [ "0.0.0.0/0" ]
      from_port = 0
      protocol = "-1"
      to_port = 0
    } 
}
resource "aws_key_pair" "my_key" {
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDHhEHeKf34JcsLdT3Jw4JCZLTGTxWah5/SNaGXTWE5GtE5FqFXZp2Y/dneE1L9I/gWrQ+o/HA82i31bcF/3cFw9Ze3X+Mnm0b1+QPOcbY0h1KMvsSeiw2bHB+aSa/UsKbTNuQwdiaGkuqdToJCSRkj3I5vm66suKk2vImeEmJJ6NyiCow+C/ql7V/K4TN/hUnbasXaKG9JXNLbbtIaDWWhoOjFXzkhNz5fftPpHIGnET+pz+hrSWkKOtULfKM0gmgh40O9LkHVKkrhLdZcLt7fHj/29WAXvDXpNwV2zilrwuC5qlNiYBlYHJO86kklj5nbtuJTHEcIOg6ao7zEfmUcd8RGNy5hGt8/CaBIbXaDWLKpfBrToN5JO7nD2omSpKmctZWyWHt+W91bTO4w+dfpXeEFt3949dAt2YrbXS6yju+sZsV6M7n5VFGrFbrdFUSHdQGK99y3PbIE03mKse0eu6IMt06b1w+D67EoNeeIV6LVjNXw/YvOixKSyBWLp5M= tangk@DESKTOP-E9F7EG6"
    key_name = "my_ec2_key"
}
resource "aws_instance" "web_instance" {
  ami           = "ami-0533f2ba8a1995cf9"
  instance_type = "t2.micro"
  key_name = aws_key_pair.my_key.key_name
  subnet_id = aws_subnet.PublicSubnet1.id
  vpc_security_group_ids = [aws_security_group.sg_web.id]
  associate_public_ip_address = true
  user_data = file("apache.sh")
}
data "aws_ami" "my_ami" {
    most_recent = true
    owners = ["amazon"]
    filter {
      name = "name"
      values = ["amzn2-ami-hvm*"] 
  }
}
resource "aws_instance" "inst1" {
  instance_type = "t2.micro"
  ami           = data.aws_ami.my_ami.id
  key_name = aws_key_pair.my_key.id 
provisioner "remote-exec" {
    inline = [
      "sudo yum -y install nano"
    ]
    connection {
        type = "ssh"
        host = self.public_ip
        user = "ec2-user"
        private_key = file("./id_rsa.pem")
      
    }

} 
provisioner "remote-exec" {
    when = destroy
    inline = [
        "sudo yum -y remove nano"
    ]
    #command = "echo ${aws_instance.inst1.private_ip} >> private_ips.txt"
    connection  {
        type = "ssh" #the type of connection to use is ssh
        host = self.public_ip #this is the ip of our instance
        user = "ec2-user" #basic user is ec2-user for ubuntu the user is ubuntu
        private_key = file("./id_rsa.pem")
    }
}
}
