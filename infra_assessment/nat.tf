resource "aws_eip" "demovpc-nat" {
  vpc = true
}

resource "aws_nat_gateway" "demovpc-nat-gw" {
  allocation_id = aws_eip.demovpc-nat.id
  subnet_id     = aws_subnet.demovpc-public-1.id
  depends_on    = [aws_internet_gateway.demovpc-gw]
}

resource "aws_route_table" "demovpc-private" {
  vpc_id = aws_vpc.demo-vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.demovpc-nat-gw.id
  }

  tags = {
    "Name" = "demovpc-private"
  }
}

# Route association private
resource "aws_route_table_association" "demovpc-private-1-a" {
  subnet_id      = aws_subnet.demovpc-private-1.id
  route_table_id = aws_route_table.demovpc-private.id
}