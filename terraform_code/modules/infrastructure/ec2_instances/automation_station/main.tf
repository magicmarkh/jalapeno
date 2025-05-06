// modules/automation_station/main.tf
resource "aws_instance" "automation_station" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = var.vpc_security_group_ids
  associate_public_ip_address = false

  tags = {
    Name = "${var.team_name}-automation-station"
    Owner = var.asset_owner_name
    CA_iScheduler = var.iScheduler
  }
}
