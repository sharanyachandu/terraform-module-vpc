resource "aws_vpc" "main"{
    cidr_block = Var.VPC_CIDR
}