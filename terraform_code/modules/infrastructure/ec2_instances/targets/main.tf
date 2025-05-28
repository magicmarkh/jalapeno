resource "aws_instance" "linux_target_1" {
  ami                         = var.linux_ami_id
  instance_type               = var.linux_instance_type
  subnet_id                   = var.private_subnet_id
  associate_public_ip_address = false
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.linux_security_group_ids]
  private_ip = var.linux_target_1_private_ip

  tags = {
    Name  = "${var.team_name}-linux-target-1"
    Owner = var.asset_owner_name
    CA_iScheduler = var.iScheduler
  }
}

resource "aws_instance" "public_windows_server" {
  ami                         = var.windows_ami_id
  instance_type               = var.windows_instance_type
  subnet_id                   = var.private_subnet_id
  associate_public_ip_address = false
  key_name                    = var.key_name
  vpc_security_group_ids      = var.windows_security_group_ids
  private_ip = var.windows_target_1_private_ip

  tags = {
    Name  = "${var.team_name}-windows-target-1"
    Owner = var.asset_owner_name
    CA_iScheduler = var.iScheduler
  }
}
