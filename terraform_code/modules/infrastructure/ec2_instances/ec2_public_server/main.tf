resource "aws_instance" "public_linux_server" {
  ami                         = var.linux_ami_id
  instance_type               = var.linux_instance_type
  subnet_id                   = var.public_subnet_id
  associate_public_ip_address = true
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.linux_security_group_ids]

  tags = {
    Name  = "${var.team_name}-public-linux-server"
    Owner = var.asset_owner_name
    CA_iScheduler = var.iScheduler
  }
}

resource "aws_instance" "public_windows_server" {
  ami                         = var.windows_ami_id
  instance_type               = var.windows_instance_type
  subnet_id                   = var.public_subnet_id
  associate_public_ip_address = true
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.windows_security_group_ids]

  tags = {
    Name  = "${var.team_name}-public-linux-server"
    Owner = var.asset_owner_name
    CA_iScheduler = var.iScheduler
  }
}
