variable "vpc_id" {}
variable "public_subnet_id" {}
variable "team_name" {}
variable "asset_owner_name" {}
variable "linux_ami_id" {}
variable "windows_ami_id" {}
variable "iScheduler" {}
variable "linux_security_group_ids" {}
variable "windows_security_group_ids" {}

variable "linux_instance_type" {
  description = "instance type to be deployed"
  type = string
  default = "t3a.micro"
}

variable "windows_instance_type" {
  description = "instance type to be deployed"
  type = string
  default = "t3a.medium"
}
variable "key_name" {
  description = "The name of the AWS key pair to use for the instance"
}
variable "trusted_ips" {
  description = "Your public IP address in CIDR format (e.g. '203.0.113.5/32')"
}
