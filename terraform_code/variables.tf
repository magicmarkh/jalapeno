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