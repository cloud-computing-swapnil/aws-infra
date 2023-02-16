
# terraform aws create vpc
resource "aws_vpc" "vpc" {
  cidr_block              = "${var.vpc-cidr}"
  instance_tenancy        = "default"


  tags      = {
    Name    = "Test VPC"
  }
}


# terraform aws create internet gateway
resource "aws_internet_gateway" "internet-gateway" {
  vpc_id    = aws_vpc.vpc.id

  tags      = {
    Name    = "Test IGW"
  }
}


# terraform aws create public subnet 1
resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "${var.public-subnet-1-cidr}"
  availability_zone = data.aws_availability_zones.available.names[0]
  

  tags      = {
    Name    = "Public Subnet 1"
  }
}


# terraform aws create public subnet 2
resource "aws_subnet" "public-subnet-2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "${var.public-subnet-2-cidr}"
  availability_zone = data.aws_availability_zones.available.names[1]


  tags      = {
    Name    = "Public Subnet 2"
  }
}

# terraform aws create public subnet 3
resource "aws_subnet" "public-subnet-3" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "${var.public-subnet-3-cidr}"
  availability_zone = data.aws_availability_zones.available.names[2]
  

  tags      = {
    Name    = "Public Subnet 3"
  }
}


# terraform aws create route table and add public route
resource "aws_route_table" "public-route-table" {
  vpc_id       = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
  }

  tags       = {
    Name     = "Public Route Table"
  }
}

# Associate Public Subnet 1 to "Public Route Table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "public-subnet-1-route-table-association" {
  subnet_id           = aws_subnet.public-subnet-1.id
  route_table_id      = aws_route_table.public-route-table.id
}

# Associate Public Subnet 2 to "Public Route Table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "public-subnet-2-route-table-association" {
  subnet_id           = aws_subnet.public-subnet-2.id
  route_table_id      = aws_route_table.public-route-table.id
}

# Associate Public Subnet 3 to "Public Route Table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "public-subnet-3-route-table-association" {
  subnet_id           = aws_subnet.public-subnet-3.id
  route_table_id      = aws_route_table.public-route-table.id
}


# terraform aws create private subnet 1
resource "aws_subnet" "private-subnet-1" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = "${var.private-subnet-1-cidr}"
  availability_zone = data.aws_availability_zones.available.names[0]
  

  tags      = {
    Name    = "Private Subnet 1"
  }
}


# terraform aws create private subnet 2
resource "aws_subnet" "private-subnet-2" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = "${var.private-subnet-2-cidr}"
  availability_zone = data.aws_availability_zones.available.names[1]
 

  tags      = {
    Name    = "Private Subnet 2"
  }
}


# terraform aws create private subnet 3
resource "aws_subnet" "private-subnet-3" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = "${var.private-subnet-3-cidr}"
  availability_zone = data.aws_availability_zones.available.names[2]
  

  tags      = {
    Name    = "Private Subnet 3"
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
 subnet_id = aws_subnet.private-subnet-1.id
 route_table_id= aws_route_table.private-route-table.id
}

# Associate Private Subnet 2 to "Private Route Table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "private-subnet-2-route-table-association" {
subnet_id = aws_subnet.private-subnet-2.id
route_table_id = aws_route_table.private-route-table.id
}

# Associate Private Subnet 3 to "Public Route Table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "private-subnet-3-route-table-association" {
subnet_id = aws_subnet.private-subnet-3.id
route_table_id = aws_route_table.private-route-table.id
}


