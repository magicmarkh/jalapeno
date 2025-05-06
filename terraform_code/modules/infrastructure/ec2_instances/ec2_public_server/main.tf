resource "aws_instance" "public_server" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  associate_public_ip_address = true
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.vpc_security_group_ids]

  tags = {
    Name  = "${var.team_name}-public-linux-server"
    Owner = var.asset_owner_name
    CA_iScheduler = var.iScheduler
  }
}
