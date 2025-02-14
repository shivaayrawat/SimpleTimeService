# VPC Setup
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
}

# Public Subnet in AZ A
resource "aws_subnet" "public_a" {
  vpc_id                   = aws_vpc.main.id
  cidr_block               = var.subnet_public_a_cidr
  availability_zone        = "us-east-1a"
  map_public_ip_on_launch  = true
}

# Public Subnet in AZ B
resource "aws_subnet" "public_b" {
  vpc_id                   = aws_vpc.main.id
  cidr_block               = var.subnet_public_b_cidr
  availability_zone        = "us-east-1b"
  map_public_ip_on_launch  = true
}

# Private Subnet in AZ A
resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_private_a_cidr
  availability_zone = "us-east-1a"
}

# Private Subnet in AZ B
resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_private_b_cidr
  availability_zone = "us-east-1b"
}

# Create Internet Gateway for Public Subnets
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

# Public Route Table for Public Subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# Associate Public Subnets with the Route Table
resource "aws_route_table_association" "public_a_association" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_b_association" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}

# NAT Gateway for Private Subnets to access internet (ECR)
resource "aws_eip" "nat_eip" {
   domain = "vpc"
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_a.id
}

# Route Table for Private Subnets to route through NAT Gateway
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }
}

# Associate Private Subnets with the Route Table
resource "aws_route_table_association" "private_a_association" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_b_association" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private.id
}




