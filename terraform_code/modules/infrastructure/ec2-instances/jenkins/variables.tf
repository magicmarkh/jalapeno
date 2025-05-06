variable "vpc_id" {
  description = "ID of the VPC where instances will be created"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet for the instances"
  type        = string
}

variable "ami_list" {
  description = "List of AMI IDs to launch"
  type        = list(string)
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Existing EC2 Key Pair name for SSH"
  type        = string
}

variable "ssh_allowed_cidrs" {
  description = "CIDR blocks allowed to SSH into the instances"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "associate_public_ip" {
  description = "Whether to assign a public IP"
  type        = bool
  default     = true
}

variable "team_name" {
  description = "Cloud naming identifier"
  type        = string
}

variable "asset_owner_name" {
  description = "Contact name for this asset"
  type        = string
}