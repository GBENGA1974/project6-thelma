# Main VPC

resource "aws_vpc" "thelma-VPC" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "thelma-VPC"
  }
}


# PUBLIC SUBNET1

resource "aws_subnet" "thelma-PUB1-SUB1" {
  vpc_id     = aws_vpc.thelma-VPC.id
  cidr_block = "10.0.35.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "thelma-PUB1-SUB1"
  }
}

# PUBLIC SUBNET2

resource "aws_subnet" "thelma-PUB2-SUB2" {
  vpc_id     = aws_vpc.thelma-VPC.id
  cidr_block = "10.0.37.0/24"
  availability_zone = "eu-west-2b"

  tags = {
    Name = "thelma-PUB2-SUB2"
  }
}


# PRIVATE SUBNET3

resource "aws_subnet" "thelma-Priv1-SUB3" {
  vpc_id     = aws_vpc.thelma-VPC.id
  cidr_block = "10.0.36.0/24"

  tags = {
    Name = "thelma-Priv1-SUB3"
  }
}

# PRIVATE SUBNET4

resource "aws_subnet" "thelma-Priv2-SUB4" {
  vpc_id     = aws_vpc.thelma-VPC.id
  cidr_block = "10.0.38.0/24"

  tags = {
    Name = "thelma-Priv2-SUB4"
  }
}

# PUBLIC ROUTE TABLE

resource "aws_route_table" "thelma-PUBLIC-RT" {
  vpc_id = aws_vpc.thelma-VPC.id

  tags = {
    Name = "thelma-PUBLIC-RT"
  }
}

# PRIVATE ROUTE TABLE

resource "aws_route_table" "thelma-PRIVATE-RT" {
  vpc_id = aws_vpc.thelma-VPC.id

  tags = {
    Name = "thelma-PRIVATE-RT"
  }
}

# PUBLIC SUBNET1 ASSOCIATION WITH PUBLIC ROUTE TABLE

resource "aws_route_table_association" "thelma-PUBSUB1-ASSOC-PUB-RT" {
  subnet_id      = aws_subnet.thelma-PUB1-SUB1.id
  route_table_id = aws_route_table.thelma-PUBLIC-RT.id
}

# PUBLIC SUBNET2 ASSOCIATION WITH PUBLIC ROUTE TABLE

resource "aws_route_table_association" "thelma-PUBSUB2-ASSOC-PUB-RT" {
  subnet_id      = aws_subnet.thelma-PUB2-SUB2.id
  route_table_id = aws_route_table.thelma-PUBLIC-RT.id
}


# PRIVATE SUBNET1 ASSOCIATION WITH PRIVATE ROUTE TABLE

resource "aws_route_table_association" "thelma-PRIVSUB3-ASSOC-PUB-RT" {
  subnet_id      = aws_subnet.thelma-Priv1-SUB3.id
  route_table_id = aws_route_table.thelma-PRIVATE-RT.id
}

# PRIVATE SUBNET2 ASSOCIATION WITH PRIVATE ROUTE TABLE

resource "aws_route_table_association" "thelma-PRIVSUB4-ASSOC-PUB-RT" {
  subnet_id      = aws_subnet.thelma-Priv2-SUB4.id
  route_table_id = aws_route_table.thelma-PRIVATE-RT.id
}

# INTERNET GATEWAY

resource "aws_internet_gateway" "thelma-igw" {
  vpc_id = aws_vpc.thelma-VPC.id

  tags = {
    Name = "thelma-igw"
  }
}


# IGW ASSOCIATION WITH ROUTE TABLE

resource "aws_route" "Assoc-public-RT" {
  route_table_id         = aws_route_table.thelma-PUBLIC-RT.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.thelma-igw.id
}


