variable "vpc_id" {}
variable "private_subnet_id" {}
variable "team_name" {}
variable "asset_owner_name" {}
variable "linux_ami_id" {}
variable "iScheduler" {}
variable "linux_security_group_ids" {}
variable "sia_aws_connector_1_private_ip" {
  description = "IP of the connector"
  type = string
}


variable "linux_ami_id_instance_type" {
  description = "instance type to be deployed"
  type = string
  default = "t3a.medium"
}
variable "key_name" {
  description = "The name of the AWS key pair to use for the instance"
}


variable "hostname" {
  description = "Desired hostname on boot"
  type        = string
  default     = "us-ent-east-sia-aws-connector-1"
}
/*
variable "cyberark_base_url" {
  description = "CyberArk base URL (e.g. https://cyberark.example.com)"
  type        = string
}

variable "cyberark_secret_name" {
  description = "AWS Secrets Manager secret name holding CyberArk creds"
  type        = string
}

variable "connector_pool_name" {
  description = "Name of the SIA Connector Pool in CyberArk"
  type        = string
}
*/