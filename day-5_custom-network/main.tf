resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
      name = "buddi"
    }
  
}

resource "aws_subnet" "name" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
    tags = {
      name = "public"
    }
  
}

resource "aws_subnet" "he" {
  vpc_id = aws_vpc.name.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "pvt"
  }

  
}

resource "aws_internet_gateway" "name" {
    vpc_id = aws_vpc.name.id
    tags = {
      name = "it"
    }
  
}

resource "aws_route_table" "name" {
vpc_id = aws_vpc.name.id
tags = {
  Name="pub-route"
}
route {
    cidr_block="0.0.0.0/0"
    gateway_id = aws_internet_gateway.name.id
}
} 
resource "aws_route_table_association" "name" {
    subnet_id = aws_subnet.name.id
    route_table_id = aws_route_table.name.id
}

resource "aws_security_group" "name" {
    name = "ssh only"
    vpc_id = aws_vpc.name.id
    tags = {
      name = "sg"
    }

    ingress {
      description = "ssh"
      from_port = 22
      to_port = 22
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  
}

resource "aws_eip" "name" {
  domain = "vpc"
  
}

resource "aws_nat_gateway" "name" {
  allocation_id = aws_eip.name.id
  subnet_id = aws_subnet.he.id
  tags = {
    Name = "nt"
  }
}
#create a rt for pvt
resource "aws_route_table" "ha" {
  vpc_id = aws_vpc.name.id
  tags = {
    name = "pvt-route"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.name.id
  }
  
}
resource "aws_route_table_association" "na" {
  route_table_id = aws_route_table.ha.id
  subnet_id = aws_subnet.he.id 
}

resource "aws_instance" "ec2" {
  ami = "ami-0c80e2b6ccb9ad6d1"
  instance_type = "t2.micro"
  key_name = "mine"
  subnet_id = aws_subnet.name.id
  security_groups = [aws_security_group.name.id]
  associate_public_ip_address = true
  tags = {
    name = "TERRAFORM EC2"
  }
  
}

#create ec2 to pvt
resource "aws_instance" "ec3" {
  ami ="ami-0c80e2b6ccb9ad6d1"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.he.id
  security_groups = [aws_security_group.name.id]
  associate_public_ip_address = true
  tags = {
    name = "TERRAFORM PVT-EC2"
  }
  
}