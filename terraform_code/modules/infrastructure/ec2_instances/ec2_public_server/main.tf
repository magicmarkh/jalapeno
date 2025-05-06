resource "aws_security_group" "ssh_only_from_my_ip" {
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
    Name  = "${var.team_name}-ssh-sg"
    Owner = var.asset_owner_name
  }
}

resource "aws_instance" "public_server" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  associate_public_ip_address = true
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.ssh_only_from_my_ip.id]

  tags = {
    Name  = "${var.team_name}-public-linux-server"
    Owner = var.asset_owner_name
    CA_iScheduler = var.iScheduler
  }
}
