resource "aws_security_group" "ec2_sg" {
  name        = "${var.team_name}-ec2-sg"
  description = "SSH access security group"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_allowed_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "${var.team_name}-ec2-sg"
    Owner = var.asset_owner_name
  }
}

resource "aws_instance" "ec2" {
  for_each                    = toset(var.ami_list)
  ami                         = each.value
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  key_name                    = var.key_name
  associate_public_ip_address = var.associate_public_ip

  tags = {
    Name  = "${var.team_name}-ec2-${each.key}"
    Owner = var.asset_owner_name
  }
}