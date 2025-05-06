output "trusted_ssh_external_security_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.ssh_from_trusted_ips.id
}

output "trusted_ssh_external_security_group_name" {
  description = "The name of the security group"
  value       = aws_security_group.ssh_from_trusted_ips.name
}
