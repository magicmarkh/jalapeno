resource "aws_security_group" "ssh_from_trusted_ips" {
  name        = "${var.team_name}-ssh-sg"
  description = "Allow SSH only from my IP"
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

  lifecycle {
    create_before_destroy = true
  }
}