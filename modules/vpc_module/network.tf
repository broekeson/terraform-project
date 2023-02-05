#Create VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = var.vpc_tenancy
  enable_dns_hostnames = true

  tags = {
    Name = "${var.vpc_tags}"
  }
}

#Create a Subnet
resource "aws_subnet" "public" {
  count                   = length(var.subnet_availability_zone)
  vpc_id                  = aws_vpc.main.id
  availability_zone       = element(var.subnet_availability_zone, count.index)
  cidr_block              = element(var.subnet_cidr_block, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.subnet_tags}-${count.index}"
  }
}

#Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.internet_gateway_tags}"
  }
}

#Create Route Table
resource "aws_route_table" "route_table" {
  count  = length(var.subnet_availability_zone)
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.route_table_tags}-${count.index}"
  }
}

#Create A Route
resource "aws_route" "route" {
  count = length(var.subnet_availability_zone)
  depends_on = [
    aws_route_table.route_table,
    aws_internet_gateway.igw
  ]
  route_table_id         = element(aws_route_table.route_table.*.id, count.index)
  destination_cidr_block = var.route_table_cidr_block
  gateway_id             = aws_internet_gateway.igw.id
}

#Create Route Table Association
resource "aws_route_table_association" "association" {
  count          = length(var.subnet_cidr_block)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = element(aws_route_table.route_table.*.id, count.index)
}