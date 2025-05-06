resource "aws_security_group" "ssh_from_trusted_ips" {
  name        = "${var.team_name}-trusted-external-ssh-sg"
  description = "Allow SSH only from trusted IPs"
  vpc_id      = var.vpc_id

dynamic "ingress" {
  for_each = var.trusted_ips
  content {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [ingress.value]
  }
}


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "${var.team_name}-trusted-ip-ssh-sg"
    Owner = var.asset_owner_name
  }
}

resource "aws_security_group" "ssh_internal_flat" {
  name        = "${var.team_name}-internal-flat-ssh-sg"
  description = "Allow SSH only from internal subnets"
  vpc_id      = var.vpc_id

dynamic "ingress" {
  for_each = var.internal_subnets
  content {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [ingress.value]
  }
}


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "${var.team_name}-trusted-ip-ssh-sg"
    Owner = var.asset_owner_name
  }
}