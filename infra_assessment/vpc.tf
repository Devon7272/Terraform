###############
# Internet VPC#
###############
resource "aws_vpc" "demo-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    "Name" = "demo-vpc"
  }
}

########################
# Public Subnets in VPC#
########################
resource "aws_subnet" "demovpc-public-1" {
  vpc_id                  = aws_vpc.demo-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"
  tags = {
    "Name" = "demovpc-public-1"
  }
}

resource "aws_subnet" "demovpc-public-2" {
  vpc_id                  = aws_vpc.demo-vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1b"
  tags = {
    "Name" = "demovpc-public-2"
  }
}
#########################
# Private Subnets in VPC#
#########################
resource "aws_subnet" "demovpc-private-1" {
  vpc_id                  = aws_vpc.demo-vpc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1a"
  tags = {
    "Name" = "demovpc-private-1"
  }
}

resource "aws_subnet" "demovpc-private-2" {
  vpc_id                  = aws_vpc.demo-vpc.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1b"
  tags = {
    "Name" = "demovpc-private-2"
  }
}

##############
# Internet GW#
##############
resource "aws_internet_gateway" "demovpc-gw" {
  vpc_id = aws_vpc.demo-vpc.id
  tags = {
    "Name" = "demovpc-gw"
  }
}





###############
# route table #
###############
resource "aws_route_table" "demovpc-rt-public" {
  vpc_id = aws_vpc.demo-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demovpc-gw.id
  }
  tags = {
    "Name" = "demovpc-rt-public"
  }
}

############################
# route associations public#
############################
resource "aws_route_table_association" "demovpc-public-1-a" {
  subnet_id      = aws_subnet.demovpc-public-1.id
  route_table_id = aws_route_table.demovpc-rt-public.id
}

resource "aws_route_table_association" "demovpc-public-2-a" {
  subnet_id      = aws_subnet.demovpc-public-2.id
  route_table_id = aws_route_table.demovpc-rt-public.id
}