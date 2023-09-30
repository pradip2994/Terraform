//Before Adding AWS provider install AWS CLI and configure AWS CLI
//ADD Secret Key,Access Key and Region 



// Deploying AWS Resources

// Deploying VPC

resource "aws_vpc" "my_vpc" {
  cidr_block = var.cidr
  tags = {
    Name = "newVPC"
  }
}

// Deploying Public Subnet

resource "aws_subnet" "my_subnet1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "Subnet1"
  }
}

// Deploying Internet gateway

resource "aws_internet_gateway" "my_vpc" {
  tags = {
    Name = "my_IGW"
  }
}

// Internet Gateway Attachement to VPC

resource "aws_internet_gateway_attachment" "my_vpc" {
  internet_gateway_id = aws_internet_gateway.my_vpc.id
  vpc_id           = aws_vpc.my_vpc.id
  
}

// Deploying Public Route Table

resource "aws_route_table" "my_route_table1" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "RouteTable"
  }
}

// Giving Routes to Internet Gateway to Public Route Table 

resource "aws_route" "default_route1" {
  route_table_id         = aws_route_table.my_route_table1.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_vpc.id
  depends_on             = [aws_internet_gateway_attachment.my_vpc]
}



// Associations of Public subnet with Public Route table

resource "aws_route_table_association" "associate_subnet1" {
  subnet_id      = aws_subnet.my_subnet1.id
  route_table_id = aws_route_table.my_route_table1.id

}

// Creating Key Pair
// To get id_rsa.pub do ssh-keygen on machine where you are using

resource "aws_key_pair" "demo_key" {
  key_name   = "demo-key"  // Replace with your desired key name
  public_key = file("~/.ssh/id_rsa.pub")  // Replace with the path to your public key file
}



// Deploying Public instance Security group

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
    Name = "EC2Instance-SG"
  }
}

// Deploying Public Instance

resource "aws_instance" "my_instance1" {
  ami           = var.ami1
  instance_type = var.instance_type1
  subnet_id     = aws_subnet.my_subnet1.id
  key_name      = aws_key_pair.demo_key.key_name
  vpc_security_group_ids = [aws_security_group.server_a_security_group.id]
  
  tags = {
    Name = "Instance-1"
  }

 // Connecting to instance

  connection {
    type        = "ssh"
    user        = "ubuntu"  // Replace with the appropriate username for your EC2 instance
    private_key = file("~/.ssh/id_rsa")  // Replace with the path to your private key
    host        = self.public_ip
  }

 // File provisioner to copy a file from local to the remote EC2 instance

  provisioner "file" {
    source      = "app.py"  // Replace with the path to your local file
    destination = "/home/ubuntu/app.py"  // Replace with the path on the remote instance
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Hello from the remote instance'",
      "sudo apt update -y",  // Update package lists (for ubuntu)
      "sudo apt-get install -y python3-pip",  // Example package installation
      "cd /home/ubuntu",
      "sudo pip3 install flask",   // Install Flask
      "sudo python3 app.py &",
    ]
  }
}
