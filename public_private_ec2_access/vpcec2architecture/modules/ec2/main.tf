resource "aws_security_group" "public_sg" {
  vpc_id = var.vpc_id

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
  vpc_id = var.vpc_id

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

data "aws_ami" "windows" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base-*"]
  }
}

# Public EC2 (Bastion)
resource "aws_instance" "public" {
  ami                    = data.aws_ami.windows.id
  instance_type          = "t3.micro"
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  key_name               = var.key_name

  associate_public_ip_address = true

  tags = { Name = "public-ec2-weltec-teraform" }
}

# Private EC2
resource "aws_instance" "private" {
  ami                    = data.aws_ami.windows.id
  instance_type          = "t3.micro"
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  key_name               = var.key_name

  tags = { Name = "private-ec2-weltec-teraform" }
}