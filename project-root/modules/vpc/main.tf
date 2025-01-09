resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

# Subnet_1
resource "aws_subnet" "web_subnet_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.web_subnet_1_cidr
  availability_zone       = var.subnet_1_az
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.vpc_name}-web_subnet_1"
  }
}

# Subnet_2
resource "aws_subnet" "web_subnet_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.web_subnet_2_cidr
  availability_zone       = var.subnet_2_az
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.vpc_name}-web_subnet_2"
  }
}
#elb security group
resource "aws_security_group" "elb_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

# Routing Table
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.vpc_name}-main-route-table"
  }
}

# Route Table Association
resource "aws_route_table_association" "web_subnet_1" {
  subnet_id      = aws_subnet.web_subnet_1.id
  route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "web_subnet_2" {
  subnet_id      = aws_subnet.web_subnet_2.id
  route_table_id = aws_route_table.main.id
}

# Security Groups
resource "aws_security_group" "web_subnet_1sg" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.vpc_name}-web_subnet_1sg"
  }
}

resource "aws_security_group" "web_subnet_2sg" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.vpc_name}-web_subnet_2sg"
  }
}
