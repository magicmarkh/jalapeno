// modules/automation_station/main.tf
resource "aws_instance" "this" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  key_name               = var.ssh_key_name
  vpc_security_group_ids = var.security_group_ids
  associate_public_ip_address = false

  tags = {
    Name = "automation_station"
  }
}
