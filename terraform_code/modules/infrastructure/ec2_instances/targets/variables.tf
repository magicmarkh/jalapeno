variable "vpc_id" {}
variable "private_subnet_id" {}
variable "team_name" {}
variable "asset_owner_name" {}
variable "linux_ami_id" {}
variable "windows_ami_id" {default = "ami-06fbbb433da1a5bf7"}
variable "iScheduler" {}
variable "linux_security_group_ids" {}
variable "windows_security_group_ids" {}
variable "windows_target_1_private_ip" {}
variable "linux_target_1_private_ip" {}

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
