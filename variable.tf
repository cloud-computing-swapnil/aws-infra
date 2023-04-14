# VPC Variables
variable "region" {
  default     = "us-east-1"
  description = "AWS Region"
  type        = string
}

variable "vpc-cidr" {
  default     = "10.0.0.0/16"
  description = "VPC CIDR Block"
  type        = string
}

variable "public-subnet-1-cidr" {
  default     = "10.0.0.0/24"
  description = "Public Subnet 1 CIDR Block"
  type        = string
}

variable "public-subnet-2-cidr" {
  default     = "10.0.1.0/24"
  description = "Public Subnet 2 CIDR Block"
  type        = string
}
variable "public-subnet-3-cidr" {
  default     = "10.0.2.0/24"
  description = "Public Subnet 2 CIDR Block"
  type        = string
}

variable "private-subnet-1-cidr" {
  default     = "10.0.3.0/24"
  description = "Private Subnet 1 CIDR Block"
  type        = string
}

variable "private-subnet-2-cidr" {
  default     = "10.0.4.0/24"
  description = "Private Subnet 2 CIDR Block"
  type        = string
}

variable "private-subnet-3-cidr" {
  default     = "10.0.5.0/24"
  description = "Private Subnet 3 CIDR Block"
  type        = string
}

variable "cidr_block" {
  default     = "0.0.0.0/0"
  description = "CIDR Block"
  type        = string
}
variable "default_region" {
  default     = "us-east-1"
  description = "default_region"
  type        = string
}
variable "profile" {
  default     = "demo"
  description = "Profile"
  type        = string
}
data "aws_availability_zones" "available" {
  state = "available"
}

variable "ami_id" {
  description = "AMI for Ubuntu Ec2 instance"
  default     = "ami-03386e28a365e7b72"
  type        = string
}

variable "db_password" {
  description = "DB PASSWORD"
  default     = "postrest"
  type        = string
}
variable "environment" {
  default = "demo"
  type    = string
}
variable "port" {
  default = 5432
  type    = number
}
variable "root_domain_name" {
  description = "Domain name"
  type        = string
  default     = "demo.swapnilsalsankar.me"
}

variable "cpu_upper_limit" {
  type    = string
  default = "1.3"
}

variable "cpu_lower_limit" {
  type    = string
  default = "1"
}