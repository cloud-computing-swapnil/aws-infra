# Create VPC
# terraform aws create vpc
resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc-cidr
  instance_tenancy = "default"

  tags = {
    Name = "Test VPC"
  }
}

# Create Internet Gateway and Attach it to VPC
# terraform aws create internet gateway
resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Test IGW"
  }
}

# Create Public Subnet 1
# terraform aws create subnet
resource "aws_subnet" "public-subnet-1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public-subnet-1-cidr
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "Public Subnet 1"
  }
}

# Create Public Subnet 2
# terraform aws create subnet
resource "aws_subnet" "public-subnet-2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public-subnet-2-cidr
  availability_zone = data.aws_availability_zones.available.names[1]


  tags = {
    Name = "Public Subnet 2"
  }
}

# Create Public Subnet 3
# terraform aws create subnet
resource "aws_subnet" "public-subnet-3" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public-subnet-3-cidr
  availability_zone = data.aws_availability_zones.available.names[2]


  tags = {
    Name = "Public Subnet 3"
  }
}

# Create Route Table and Add Public Route
# terraform aws create route table
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.cidr_block
    gateway_id = aws_internet_gateway.internet-gateway.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

# Associate Public Subnet 1 to "Public Route Table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "public-subnet-1-route-table-association" {

  depends_on = [
    aws_route_table.public-route-table,
    aws_subnet.public-subnet-1
  ]


  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.public-route-table.id
}

# Associate Public Subnet 2 to "Public Route Table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "public-subnet-2-route-table-association" {
  depends_on = [
    aws_route_table.public-route-table,
    aws_subnet.public-subnet-2
  ]
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.public-route-table.id
}

# Associate Public Subnet 3 to "Public Route Table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "public-subnet-3-route-table-association" {
  depends_on = [
    aws_route_table.public-route-table,
    aws_subnet.public-subnet-3
  ]

  subnet_id      = aws_subnet.public-subnet-3.id
  route_table_id = aws_route_table.public-route-table.id
}


# Create Private Subnet 1
# terraform aws create subnet
resource "aws_subnet" "private-subnet-1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private-subnet-1-cidr
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "Private Subnet 1"
  }
}

# Create Private Subnet 2
# terraform aws create subnet
resource "aws_subnet" "private-subnet-2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private-subnet-2-cidr
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "Private Subnet 2"
  }
}

# Create Private Subnet 3
# terraform aws create subnet
resource "aws_subnet" "private-subnet-3" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private-subnet-3-cidr
  availability_zone = data.aws_availability_zones.available.names[2]

  tags = {
    Name = "Private Subnet 3"
  }
}

# Create Route Table and Add Private Route
# terraform aws create route table
resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Private Route Table"
  }
}



# Associate Private Subnet 1 to "Private Route Table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "private-subnet-1-route-table-association" {
  subnet_id      = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.private-route-table.id
}

# Associate Private Subnet 2 to "Private Route Table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "private-subnet-2-route-table-association" {
  subnet_id      = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.private-route-table.id
}

# Associate Private Subnet 3 to "Private Route Table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "private-subnet-3-route-table-association" {
  subnet_id      = aws_subnet.private-subnet-3.id
  route_table_id = aws_route_table.private-route-table.id
}


resource "aws_security_group" "application_security_group" {
  name        = "application_security_group"
  description = "allow on port 8080"
  vpc_id    = aws_vpc.vpc.id


  ingress {
    from_port        = 8000
    to_port          = 8000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
# data "aws_ami" "app_ami" {
#   most_recent = true
#   name_regex  = "CUSTOMIZE_-*"
#   owners      = ["self"]
# }

resource "aws_instance" "web_app" {
  instance_type          = "t2.micro"
  ami                    = "ami-09b2951891672588a"
  vpc_security_group_ids = [aws_security_group.application_security_group.id]
  subnet_id              = aws_subnet.public-subnet-1.id
  associate_public_ip_address = true
  disable_api_termination = true
  # root disk
  
  # data disk
  ebs_block_device {
    device_name           = "/dev/xvda"
    volume_size           = "50"
    volume_type           = "gp2"
    encrypted             = true
    delete_on_termination = true
  }
   tags      = {
    Name    = "Test EC2"
  }
}