output "generated_password" {
  description = "Generated MySQL password"
  value       = random_password.mysql_admin.result
  sensitive   = true
}
