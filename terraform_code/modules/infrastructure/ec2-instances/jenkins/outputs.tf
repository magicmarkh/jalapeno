output "instance_ids" {
  description = "List of EC2 instance IDs"
  value       = [for inst in aws_instance.ec2 : inst.id]
}

output "public_ips" {
  description = "List of public IPs"
  value       = [for inst in aws_instance.ec2 : inst.public_ip]
}

output "private_ips" {
  description = "List of private IPs"
  value       = [for inst in aws_instance.ec2 : inst.private_ip]
}