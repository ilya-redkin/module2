resource "aws_vpc" "wordpress-workshop" {
  cidr_block           = "192.168.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = merge(
    var.common_tags,
    {
      Name = "Wordpress-workshop"
    }
  )
}

resource "aws_subnet" "public_subnet_a" {
  vpc_id            = aws_vpc.wordpress-workshop.id
  availability_zone = "us-east-1a"
  cidr_block        = "192.168.0.0/24"
  tags = merge(
    var.common_tags,
    {
      Name = "Public Subnet A"
    }
  )
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id            = aws_vpc.wordpress-workshop.id
  availability_zone = "us-east-1b"
  cidr_block        = "192.168.1.0/24"
  tags = merge(
    var.common_tags,
    {
      Name = "Public Subnet B"
    }
  )
}

resource "aws_subnet" "application_subnet_a" {
  vpc_id            = aws_vpc.wordpress-workshop.id
  availability_zone = "us-east-1a"
  cidr_block        = "192.168.2.0/24"
  tags = merge(
    var.common_tags,
    {
      Name = "Application Subnet A"
    }
  )
}

resource "aws_subnet" "application_subnet_b" {
  vpc_id            = aws_vpc.wordpress-workshop.id
  availability_zone = "us-east-1b"
  cidr_block        = "192.168.3.0/24"
  tags = merge(
    var.common_tags,
    {
      Name = "Application Subnet B"
    }
  )
}

resource "aws_subnet" "data_subnet_a" {
  vpc_id            = aws_vpc.wordpress-workshop.id
  availability_zone = "us-east-1a"
  cidr_block        = "192.168.4.0/24"
  tags = merge(
    var.common_tags,
    {
      Name = "Data Subnet A"
    }
  )
}

resource "aws_subnet" "data_subnet_b" {
  vpc_id            = aws_vpc.wordpress-workshop.id
  availability_zone = "us-east-1b"
  cidr_block        = "192.168.5.0/24"
  tags = merge(
    var.common_tags,
    {
      Name = "Data Subnet B"
    }
  )
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.wordpress-workshop.id
  tags = merge(
    var.common_tags,
    {
      Name = "WP Internet Gateway"
    }
  )
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.wordpress-workshop.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(
    var.common_tags,
    {
      Name = "WP Public RT"
    }
  )
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_eip" "nat_gw_eip-a" {
  vpc = true
}

resource "aws_eip" "nat_gw_eip-b" {
  vpc = true
}

resource "aws_nat_gateway" "nat-gw-a" {
  allocation_id = aws_eip.nat_gw_eip-a.id
  subnet_id     = aws_subnet.public_subnet_a.id
  depends_on = [
    aws_internet_gateway.igw
  ]
  tags = merge(
    var.common_tags,
    {
      Name = "NAT Public Subnet A"
    }
  )
}

resource "aws_nat_gateway" "nat-gw-b" {
  allocation_id = aws_eip.nat_gw_eip-b.id
  subnet_id     = aws_subnet.public_subnet_b.id
  depends_on = [
    aws_internet_gateway.igw
  ]
  tags = merge(
    var.common_tags,
    {
      Name = "NAT Public Subnet B"
    }
  )
}

resource "aws_route_table" "nat_rt_a" {
  vpc_id = aws_vpc.wordpress-workshop.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gw-a.id
  }

  tags = merge(
    var.common_tags,
    {
      Name = "WP NAT RT A"
    }
  )
}

resource "aws_route_table_association" "nat_a" {
  subnet_id      = aws_subnet.application_subnet_a.id
  route_table_id = aws_route_table.nat_rt_a.id
}

resource "aws_route_table" "nat_rt_b" {
  vpc_id = aws_vpc.wordpress-workshop.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gw-b.id
  }

  tags = merge(
    var.common_tags,
    {
      Name = "WP NAT RT B"
    }
  )
}

resource "aws_route_table_association" "nat_b" {
  subnet_id      = aws_subnet.application_subnet_b.id
  route_table_id = aws_route_table.nat_rt_b.id
}