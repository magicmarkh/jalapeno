variable "vpc_id" {}
variable "private_subnet_id" {}
variable "team_name" {}
variable "asset_owner_name" {}
variable "ami_id" {}
variable "iScheduler" {}
variable "vpc_security_group_ids" {}

variable "instance_type" {
  description = "instance type to be deployed"
  type = string
  default = "t2.medium"
}
variable "key_name" {
  description = "The name of the AWS key pair to use for the instance"
}
