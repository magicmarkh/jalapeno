// modules/automation_station/variables.tf
variable "ami" {
  description = "AMI ID for the automation station"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for the automation station"
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "ID of the private subnet where the instance will live"
  type        = string
}

variable "ssh_key_name" {
  description = "Name of the existing AWS Key Pair for SSH access"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs to attach"
  type        = list(string)
}
