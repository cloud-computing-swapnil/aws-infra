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
  vpc_id      = aws_vpc.vpc.id


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
data "aws_ami" "app_ami" {
  most_recent = true
  name_regex  = "CUSTOMIZE_-*"
  owners      = ["self"]
}

resource "aws_instance" "web_app" {
  instance_type               = "t2.micro"
  ami                         = data.aws_ami.app_ami.id
  vpc_security_group_ids      = [aws_security_group.application_security_group.id]
  subnet_id                   = aws_subnet.public-subnet-1.id
  iam_instance_profile        = aws_iam_instance_profile.some_profile.id
  associate_public_ip_address = true
  disable_api_termination     = false
  user_data=<<-EOF
      #!/bin/bash
      echo "The Webapp"
      /bin/echo
      cat <<-EOF >>/home/ec2-user/webApp/.env
      DB_HOST=${aws_db_instance.database.address}
      DB_USER=${aws_db_instance.database.username}
      DB_PASSWORD=${var.db_password}
      BUCKET_NAME=${aws_s3_bucket.S3Bucket.bucket}
      DB_DATABASE_NAME=${aws_db_instance.database.username}
      BUCKET_REGION=${var.default_region}
      DB_PORT=${var.port}
      EOF
  # root disk
  root_block_device {
    volume_size           = "20"
    volume_type           = "gp2"
    encrypted             = true
    delete_on_termination = true
  }
  # data disk
  ebs_block_device {
    device_name           = "/dev/xvda"
    volume_size           = "50"
    volume_type           = "gp2"
    encrypted             = true
    delete_on_termination = true
  }
  tags = {
    Name = "Test EC2"
  }
}





# create security group for the database
resource "aws_security_group_rule" "ssh" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.application_security_group.id
  security_group_id        = aws_security_group.database_security_group.id
}

resource "aws_security_group" "database_security_group" {
  name   = "RDS"
  vpc_id = aws_vpc.vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "RDS"
  }
}

#create RDS PARAMETER GROUP
resource "aws_db_parameter_group" "paramter_group" {
  name   = "my-pg"
  family = "postgres14"
}

# create the subnet group for the rds instance
resource "aws_db_subnet_group" "database_subnet_group" {
  name       = "database-subnets"
  subnet_ids = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id, aws_subnet.private-subnet-3.id]

  tags = {
    Name = "database-subnets"
  }
}


#create RDS DB INSTANCE
resource "aws_db_instance" "database" {
  db_name                     = "csye6225"
  engine                      = "postgres"
  instance_class              = "db.t3.micro"
  multi_az                    = false
  identifier                  = "csye6225"
  allocated_storage           = 10
  username                    = "csye6225"
  password                    = var.db_password
  publicly_accessible         = false
  skip_final_snapshot         = true
  db_subnet_group_name        = aws_db_subnet_group.database_subnet_group.name
  parameter_group_name        = aws_db_parameter_group.paramter_group.name
  apply_immediately           = true
  vpc_security_group_ids = [aws_security_group.database_security_group.id]

}
 


#Create IAM ROLE
resource "aws_iam_role" "EC2-CSYE6225" {
  name = "EC2-CSYE6225"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Create IAM Policy
resource "aws_iam_policy" "bucket_policy" {
  name        = "my-bucket-policy"
  path        = "/"
  description = "Allow "

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:DeleteObject",
          "s3:CreateBucket",
          "s3:DeleteBucket"
        ],
        "Resource" : [
          "arn:aws:s3:::${aws_s3_bucket.S3Bucket.bucket}",
          "arn:aws:s3:::${aws_s3_bucket.S3Bucket.bucket}/*"
        ]
      }
    ]
  })
}

#Attach Policy
resource "aws_iam_role_policy_attachment" "policy" {
  role       = aws_iam_role.EC2-CSYE6225.name
  policy_arn = aws_iam_policy.bucket_policy.arn
}
resource "aws_iam_instance_profile" "some_profile" {
  name = "some-profile"
  role = aws_iam_role.EC2-CSYE6225.name
}



# Create S3 Bucket
resource "random_id" "bucket_name_suffix" {
  byte_length = 8
}

resource "aws_s3_bucket" "S3Bucket" {
  bucket        = "my-bucket-${var.environment}-${random_id.bucket_name_suffix.hex}"
  acl           = "private"
  force_destroy = true

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  lifecycle_rule {
    id      = "transition-to-standard-ia"
    enabled = true

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    noncurrent_version_transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
  }
}

# Make S3bucket private
resource "aws_s3_bucket_public_access_block" "some_bucket_access" {
  bucket = aws_s3_bucket.S3Bucket.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
}




