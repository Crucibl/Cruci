# Production VPC
resource "aws_vpc" "prod_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

# Public subnets
resource "aws_subnet" "public_subnet_1" {
  cidr_block        = var.public_access_1
  vpc_id            = aws_vpc.prod_vpc.id
  availability_zone = var.availability_zones[0]
}
resource "aws_subnet" "public_subnet_2" {
  cidr_block        = var.public_access_2
  vpc_id            = aws_vpc.prod_vpc.id
  availability_zone = var.availability_zones[1]
}

# Private subnets
resource "aws_subnet" "private_subnet_1" {
  cidr_block        = var.private_access_1
  vpc_id            = aws_vpc.prod_vpc.id
  availability_zone = var.availability_zones[0]
}
resource "aws_subnet" "private_subnet_2" {
  cidr_block        = var.private_access_2
  vpc_id            = aws_vpc.prod_vpc.id
  availability_zone = var.availability_zones[1]
}

# Route tables for the subnets
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.prod_vpc.id
}
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.prod_vpc.id
}

#Associate the route tables
resource "aws_route_table_association" "public_route_1_association" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnet_1.id
}
resource "aws_route_table_association" "public_route_2_association" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnet_2.id
}
resource "aws_route_table_association" "private_route_1_association" {
  route_table_id = aws_route_table.private_route_table.id
  subnet_id      = aws_subnet.private_subnet_1.id
}
resource "aws_route_table_association" "private_route_2_association" {
  route_table_id = aws_route_table.private_route_table.id
  subnet_id      = aws_subnet.private_subnet_2.id
}

# Create an elastic IP
resource "aws_eip" "elastic_ip_for_nat_gw" {
  vpc                       = true
  associate_with_private_ip = "10.0.0.5"
  depends_on                = [aws_internet_gateway.production_igw]
}

# NAT gateway
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.elastic_ip_for_nat_gw.id
  subnet_id     = aws_subnet.public_subnet_1.id
  depends_on    = [aws_eip.elastic_ip_for_nat_gw]
}
resource "aws_route" "nat_gw_route" {
  route_table_id         = aws_route_table.private_route_table.id
  nat_gateway_id         = aws_nat_gateway.nat_gw.id
  destination_cidr_block = "0.0.0.0/0"
}

# Internet Gateway for the public subnet
resource "aws_internet_gateway" "production_igw" {
  vpc_id = aws_vpc.prod_vpc.id
}

# Route the public subnet traffic through the Internet Gateway
resource "aws_route" "public_internet_igw_route" {
  route_table_id         = aws_route_table.public_route_table.id
  gateway_id             = aws_internet_gateway.production_igw.id
  destination_cidr_block = "0.0.0.0/0"
}
