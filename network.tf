resource "aws_vpc" "vpn-vpc" {
  cidr_block = "192.168.1.0/24"

  tags = {
    Name = "vpn-vpc"
  }
}

resource "aws_subnet" "vpn" {
  vpc_id            = aws_vpc.vpn-vpc.id
  cidr_block        = "192.168.1.0/25"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "service" {
  vpc_id            = aws_vpc.vpn-vpc.id
  cidr_block        = "192.168.1.128/25"
  availability_zone = "us-east-1b"
}

resource "aws_route_table" "vpn-route-table" {
  vpc_id = aws_vpc.vpn-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "vpn-association" {
  subnet_id      = aws_subnet.vpn.id
  route_table_id = aws_route_table.vpn-route-table.id

  depends_on = [aws_route_table.vpn-route-table, aws_internet_gateway.igw]
}

resource "aws_route_table_association" "services-association" {
  subnet_id      = aws_subnet.service.id
  route_table_id = aws_route_table.vpn-route-table.id

  depends_on = [aws_route_table.vpn-route-table, aws_internet_gateway.igw]
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpn-vpc.id

  tags = {
    Name = "vpn igw"
  }
}