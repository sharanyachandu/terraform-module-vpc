# Elastic IP Needed for NAT GW
resource "aws_eip" "ngw-eip" {
  vpc       = true

  tags = {
      Name  = "robot-${var.ENV}-ngw-eip"
  }
}


# Created NAT Gateway to expose the public network to Private machines
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.ngw-eip.id
  subnet_id     = aws_subnet.public_subnet.*.id[0]

  tags   = {
    Name = "robot-${var.ENV}-ngw"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_eip.ngw-eip]
}
