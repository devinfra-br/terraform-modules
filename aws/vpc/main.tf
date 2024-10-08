resource "aws_vpc" "main" {
  cidr_block = var.cidr
}

resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet1
}