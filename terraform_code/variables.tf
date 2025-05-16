variable "asset_owner_name" {
  description = "Name of the human that the cloud team can contact with questions"
  default = "Mark Hurter"
  type = string
}

variable "region" {
  description = "AWS cloud region for the deployment"
  default = "us-east-2"
  type = string
}

variable "team_name" {
  description = "cloud naming identifier"
  default = "us-ent-east"
  type = string
}

variable "private_subnet_az" {
  description = "AWS identifier for the private subnet AZ"
  default = "us-east-2b"
  type = string
}

variable "public_subnet_az" {
  description = "AWS identifier for the public subnet AZ"
  default = "us-east-2a"
  type = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "192.168.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for your public subnet"
  default = "192.168.50.0/24"
  type = string
}

variable "private_subnet_cidr" {
  description = "CIDR block for your private subnet"
  default = "192.168.20.0/24"
  type = string
}

variable "amzn_linux_ami_id" {
  description = "ami id for amazon linux ec2"
  type = string
  default = "ami-058a8a5ab36292159"
}

variable "amzn_windows_server_ami_id" {
  description = "ami id for amazon windows ec2"
  type = string
  default = "ami-06fbbb433da1a5bf7"
}

variable "iScheduler" {
  description = "use if the system should be shutdown nightly"
  type = string
  default = "US_E_office"
}

variable "trusted_ips" {
  description = "trusted public IP's"
  type = list(string)
}

variable "automation_station_private_ip" {
  description = "private ip of automation station"
  type = string
}

variable "dc1_private_ip" {
  description = "private ip of dc1"
  type = string
}

variable "linux_target_1_private_ip" {
  description = "private ip of linux target 1"
  type = string
}

variable "windows_target_1_private_ip" {
  description = "private ip of windows target 1"
  type = string
}

variable "connector_1_private_ip" {
  description = "private ip of windows target 1"
  type = string
}

variable "sia_aws_connector_1_private_ip" {
  description = "private ip of windows target 1"
  type = string
}