resource "aws_subnet" "private_subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.private_subnet_cidr
  map_public_ip_on_launch = false

  tags = {
      Name = "${var.name_prefix}-private-subnet"
  }
}

resource "aws_eip" "nat_eip" {
  depends_on = [var.igw_dependency]

  tags = {
    Name = "${var.name_prefix}-nat-eip"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = var.public_subnet_id

  tags = {
    Name = "${var.name_prefix}-nat-gw"
  }

  depends_on = [var.igw_dependency]
}

resource "aws_route_table" "private_route_table" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.name_prefix}-private-rt"
  }
}

resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}

resource "aws_route_table_association" "private_route_table_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_security_group" "private_sg" {
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.private_sg_ingress_rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_prefix}-private-sg"
  }
}