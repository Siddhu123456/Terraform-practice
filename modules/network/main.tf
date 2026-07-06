resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "terra_vpc"
  }
}


#creating subnets using for_each
resource "aws_subnet" "this" {
  for_each = var.subnet_configurations
  vpc_id   = aws_vpc.this.id
  cidr_block = cidrsubnet(
    var.vpc_cidr,
    8,
    each.value.subnet_number
  )
  availability_zone       = each.value.az
  map_public_ip_on_launch = each.value.map_public_ip_on_launch

  tags = {
    Name = each.value.name
  }
}

# Internet Gateway

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "terra_igw"
  }
}

# Public Route Table

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "terra_public_rt"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.this["public"].id
  route_table_id = aws_route_table.public.id
}

# Elastic IP

resource "aws_eip" "this" {
  domain = "vpc"

  tags = {
    Name = "terra_nat_eip"
  }
}

# NAT Gateway

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id     = aws_subnet.this["public"].id

  tags = {
    Name = "terra_nat_gw"
  }

  depends_on = [
    aws_internet_gateway.this
  ]
}

# Private Route Table

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.id
  }

  tags = {
    Name = "terra_pvt_rt"
  }
}

resource "aws_route_table_association" "private" {
  for_each = {
    for key, subnet in var.subnet_configurations :
    key => subnet
    if subnet.map_public_ip_on_launch == false
  }

  subnet_id      = aws_subnet.this[each.key].id
  route_table_id = aws_route_table.private.id
}