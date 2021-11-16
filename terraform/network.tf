resource "aws_vpc" "main" {
  cidr_block           = "${var.vpc_cidr_block}"
  enable_dns_hostnames = true

  tags = {
    Name    = "vpc.${var.project}"
    Project = "${var.project}"
  }
}

/* Internet gateway for the public subnet */
resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name    = "igw_${var.project}"
    Project = "${var.project}"
  }
}

/* subnet per availability zone */
resource "aws_subnet" "public_az1" {
  vpc_id                  = aws_vpc.main.id
  count                   = length(var.public_subnet_cidr_block)
  cidr_block              = element(var.public_subnet_cidr_block, count.index)
  map_public_ip_on_launch = true
  depends_on              = [aws_internet_gateway.default]
  availability_zone       = element(var.avail_zone, count.index)
  tags = {
    Name    = "public_az1_${var.project}_0${count.index + 1}"
    Project = "${var.project}"
  }
}

resource "aws_subnet" "private_az1" {
  vpc_id                  = aws_vpc.main.id
  count                   = length(var.private_subnet_cidr_block)
  cidr_block              = element(var.private_subnet_cidr_block, count.index)
  map_public_ip_on_launch = false
  availability_zone       = element(var.avail_zone, count.index)
  tags = {
    Name    = "private_az1_${var.project}_0${count.index + 1}"
    Project = "${var.project}"
  }
}

resource "aws_subnet" "private_az2" {
  vpc_id                  = aws_vpc.main.id
  count                   = length(var.private_subnet_db_cidr_block)
  cidr_block              = element(var.private_subnet_db_cidr_block, count.index)
  map_public_ip_on_launch = false
  availability_zone       = element(var.avail_zone, count.index)
  tags = {
    Name    = "private_az2_${var.project}_0${count.index + 1}"
    Project = "${var.project}"
  }
}

