//Before Adding AWS provider install AWS CLI and configure AWS CLI
//ADD Secret Key,Access Key and Region 

//Adding AWS provider

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.13.1"
    }
  }
}

//Adding Region

provider "aws" {
  region = "ap-south-1"
}

//Deploying AWS Resources

//Deploying VPC

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "newVPC"
  }
}

//Deploying Public Subnet

resource "aws_subnet" "my_public_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "ap-south-1a"
  tags = {
    Name = "Public_Subnet"
  }
}
//Deploying Private Subnet

resource "aws_subnet" "my_private_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  tags = {
    Name = "Private_Subnet"
  }
}

//Deploying Internet gateway

resource "aws_internet_gateway" "my_vpc" {}

//Internet Gateway Attachement to VPC

resource "aws_internet_gateway_attachment" "my_vpc" {
  internet_gateway_id = aws_internet_gateway.my_vpc.id
  vpc_id           = aws_vpc.my_vpc.id
  
}

//Deploying Public Route Table

resource "aws_route_table" "my_public_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "PublicRouteTable"
  }
}

//Giving Routes to Internet Gateway to Public Route Table 

resource "aws_route" "default_route1" {
  route_table_id         = aws_route_table.my_public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_vpc.id
  depends_on             = [aws_internet_gateway_attachment.my_vpc]
}

//Deploying Private Route Table

resource "aws_route_table" "my_private_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "PrivateRouteTable"
  }
}

//Associations of Public subnet with Public Route table

resource "aws_route_table_association" "associate_public_subnet" {
  subnet_id      = aws_subnet.my_public_subnet.id
  route_table_id = aws_route_table.my_public_route_table.id
}

//Associations of private subnet with Private Route Table

resource "aws_route_table_association" "associate_private_subnet" {
  subnet_id      = aws_subnet.my_private_subnet.id
  route_table_id = aws_route_table.my_private_route_table.id
}

// Deploying Public Instance

resource "aws_instance" "my_public_instance" {
  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.my_public_subnet.id
  key_name      = "mydemokey"
  vpc_security_group_ids = [aws_security_group.server_a_security_group.id]
  user_data = "${file("user_data1.sh")}"
  tags = {
    Name = "Public_Instance"
  }
}

//Deploying Public instance Security group

resource "aws_security_group" "server_a_security_group" {
  name        = "server_a_security_group1"
  description = "enabled ssh and http ports"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Public-SG"
  }
}

//Deploying Private instance  

resource "aws_instance" "my_private_instance" {
  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.my_private_subnet.id
  key_name      = "mydemokey"
  vpc_security_group_ids = [aws_security_group.server_b_security_group.id]
  
  tags = {
    Name = "Private_Instance"
  }
}

//Deploying Private instance Security Group

resource "aws_security_group" "server_b_security_group" {
  name        = "server_b_security_group2"
  description = "enabled ssh"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Private-SG"
  }
}

//Deploying Elastic IP for Public instance

resource "aws_eip" "my_eip" {
  instance = aws_instance.my_public_instance.id
}

