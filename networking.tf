resource "aws_vpc" "wordpress-workshop" {
  cidr_block = "192.168.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = merge(
    var.common_tags,
    {
      Name = "Wordpress-workshop"
    }
  )
}

resource "aws_subnet" "public_subnet_a" {
  vpc_id = aws_vpc.wordpress-workshop.id
  availability_zone = "us-east-1a"
  cidr_block = "192.168.0.0/24"
  tags = merge(
    var.common_tags,
    {
      Name = "Public Subnet A"
    }
  )
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id = aws_vpc.wordpress-workshop.id
  availability_zone = "us-east-1b"
  cidr_block = "192.168.1.0/24"
  tags = merge(
    var.common_tags,
    {
      Name = "Public Subnet B"
    }
  )
}

resource "aws_subnet" "application_subnet_a" {
  vpc_id = aws_vpc.wordpress-workshop.id
  availability_zone = "us-east-1a"
  cidr_block = "192.168.2.0/24"
  tags = merge(
    var.common_tags,
    {
      Name = "Application Subnet A"
    }
  )
}

resource "aws_subnet" "application_subnet_b" {
  vpc_id = aws_vpc.wordpress-workshop.id
  availability_zone = "us-east-1b"
  cidr_block = "192.168.3.0/24"
  tags = merge(
    var.common_tags,
    {
      Name = "Application Subnet B"
    }
  )
}

resource "aws_subnet" "data_subnet_a" {
  vpc_id = aws_vpc.wordpress-workshop.id
  availability_zone = "us-east-1a"
  cidr_block = "192.168.4.0/24"
  tags = merge(
    var.common_tags,
    {
      Name = "Data Subnet A"
    }
  )
}

resource "aws_subnet" "data_subnet_b" {
  vpc_id = aws_vpc.wordpress-workshop.id
  availability_zone = "us-east-1b"
  cidr_block = "192.168.5.0/24"
  tags = merge(
    var.common_tags,
    {
      Name = "Data Subnet B"
    }
  )
}

