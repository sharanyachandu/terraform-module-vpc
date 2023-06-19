# Created IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "roboshop-${var.ENV}-igw"
  }
}
#Creating Elastic IP for the aws_nat_gateway
resource "aws_eip" "ngw-eip" {
 vpc    =  true
 tags ={
    Name = "robot-${var.ENV}-ngw-eip"
 }
}

#Created NAT gatway to expose the public network to private machines
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.
  subnet_id     = aws_subnet.public_subnet.*.id[0]

  tags = {
    Name = "robot-${var.ENV}-ngw"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_eip.ngw-eip]
}