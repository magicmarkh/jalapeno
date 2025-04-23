variable "asset_owner_name" {
  description = "Name of the human that the cloud team can contact with questions"
  default = "Mark Hurter"
}

variable "cloud_region" {
  description = "AWS cloud region for the deployment"
  default = "us-east-2"
}

variable "team_name" {
  description = "cloud naming identifier"
  default = "us-ent-east"
}

variable "private_subnet_az" {
  description = "AWS identifier for the private subnet AZ"
  default = "us-east-2b"
}

variable "public_subnet_az" {
  description = "AWS identifier for the public subnet AZ"
  default = "us-east-2a"
}

variable "public_subnet_cidr_block" {
  description = "CIDR block for your public subnet"
  default = "192.168.50.0/24"
}

variable "private_subnet_cidr_block" {
  description = "CIDR block for your private subnet"
  default = "192.168.20.0/24"
}