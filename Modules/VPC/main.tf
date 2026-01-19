resource "aws_vpc" "custom_vpc" {
  cidr_block           = var.aws_vpc_cdir
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = merge(var.tags, { Name = "${var.project}-vpc" })
}

resource "aws_internet_gateway" "custom_igw" {
  vpc_id = aws_vpc.custom_vpc.id

   tags = merge(
    var.tags,
    { Name = "${var.project}-igw" }
  )
}

resource "aws_subnet" "subnet_public" {
  for_each = var.public_subnets

  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = each.value
  availability_zone = each.key

  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    { Name = "${var.project}-public-${each.key}" }
  )
}

resource "aws_subnet" "subnet_private" {
  for_each = var.private_subnets

  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = each.value
  availability_zone = each.key

  map_public_ip_on_launch = false

  tags = merge(
    var.tags,
    { Name = "${var.project}-private-${each.key}" }
  )
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.custom_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.custom_igw.id
  }

  tags = merge(
    var.tags,
    { Name = "${var.project}-public-rt" }
  )
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = values(aws_subnet.subnet_public)[0].id

  tags = merge(var.tags, {
    Name = "${var.project}-nat"
  })
}


resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.custom_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = merge(
    var.tags,
    { Name = "${var.project}-private-rt" }
  )
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.subnet_public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.subnet_private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_route_table.id
}