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
  cidr_block              = var.public_subnet_cidr_block
  map_public_ip_on_launch = true
  depends_on              = [aws_internet_gateway.default]
  availability_zone       = var.avail_zone[0]
  tags = {
    Name    = "public_az1_${var.project}_01"
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

resource "aws_eip" "nat" {
  vpc = var.nat_enable
}

resource "aws_nat_gateway" "gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_az1.id
  tags = {
    Project = var.project
    Name    = "${var.project} - NAT Gateway"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.gw.id
  }
  tags = {
    Project = var.project
    Name    = "${var.project} - NAT GW Routing table"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }
  tags = {
    Project = var.project
    Name    = "${var.project} - Routing table"
  }
}
/* Associate the routing table to public subnet */
resource "aws_route_table_association" "public_az1" {
  subnet_id      = aws_subnet.public_az1.id
  route_table_id = aws_route_table.public_rt.id
}

/* Associate the routing table to private subnet */
resource "aws_route_table_association" "private_az1" {
  count                   = length(var.private_subnet_cidr_block)
  subnet_id      = element(aws_subnet.private_az1.*.id, count.index)
  route_table_id = aws_route_table.private_rt.id
}

/* Associate the routing table to private subnet */
resource "aws_route_table_association" "private_az2" {
  count          = length(var.private_subnet_db_cidr_block)
  subnet_id      = element(aws_subnet.private_az2.*.id, count.index)
  route_table_id = aws_route_table.private_rt.id
}

# /* Associate the routing table to private subnet */
# resource "aws_route_table_association" "private_nat_ass" {
#   subnet_id      = aws_subnet.private_az2[count.index]
#   route_table_id = aws_route_table.private_rt.id
# }