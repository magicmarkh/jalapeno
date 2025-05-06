output "public_server_id" {
  value = aws_instance.public_server.id
}

output "public_server_ip" {
  value = aws_instance.public_server.public_ip
}
