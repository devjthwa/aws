# ---------------- VPC & Networking ----------------
resource "aws_vpc" "my_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = { Name = "VPC-Vadodara" }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "11.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${var.region}a"
  tags = { Name = "PublicSubnet" }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "11.0.2.0/24"
  availability_zone = "${var.region}a"
  tags = { Name = "PrivateSubnet" }
}

# ---------------- Gateways & Routing ----------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public.id
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "pub_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }
}

resource "aws_route_table_association" "pri_assoc" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private_rt.id
}

# ---------------- Security Groups ----------------
resource "aws_security_group" "public_sg" {
  name   = "PublicSG"
  vpc_id = aws_vpc.my_vpc.id
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "private_sg" {
  name   = "PrivateSG"
  vpc_id = aws_vpc.my_vpc.id
  ingress {
    from_port       = 3389
    to_port         = 3389
    protocol        = "tcp"
    security_groups = [aws_security_group.public_sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ---------------- EC2 Instances ----------------
resource "aws_instance" "public_win" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  key_name               = var.key_name
  tags = { Name = "Public-EC2-Vadodara" }
}

resource "aws_instance" "private_win" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  key_name               = var.key_name
  tags = { Name = "Private-EC2-Vadodara" }
}
