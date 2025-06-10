resource "aws_instance" "sia_aws_connector" {
  ami                         = var.linux_ami_id
  instance_type               = var.linux_ami_id_instance_type
  subnet_id                   = var.private_subnet_id
  associate_public_ip_address = false
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.linux_security_group_ids]
  private_ip                  = var.sia_aws_connector_1_private_ip

  user_data = templatefile("${path.module}/templates/init.sh.tpl", {
    hostname               = var.hostname,
    rename_hostname_script = file("${path.module}/scripts/init.sh")
  })

  tags = {
    Name          = "${var.team_name}-aws-sia-connector-1"
    Owner         = var.asset_owner_name
    CA_iScheduler = var.iScheduler
  }
}
