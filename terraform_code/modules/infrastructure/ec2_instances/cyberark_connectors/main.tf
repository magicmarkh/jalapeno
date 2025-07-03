resource "aws_instance" "connector_1" {
  ami                         = var.windows_ami_id
  instance_type               = var.windows_instance_type
  subnet_id                   = var.private_subnet_id
  associate_public_ip_address = false
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.windows_security_group_ids]
  private_ip = var.connector_1_private_ip

  tags = {
    Name  = "${var.team_name}-connector-1"
    Owner = var.asset_owner_name
    CA_iScheduler = var.iScheduler
  }
}
