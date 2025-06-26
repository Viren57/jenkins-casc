variable "vpc_cidr_block" {
  type = string
  description = "To set cidr for vpc"
}

variable "subnet_cidr_block" {
  type = string
  description = "To set cidr for subnet"
}

variable "availability_zone" {
  type = string
  description = "To set AWS availability region"
}

variable "env_prefix" {
  type = string
  description = "Set as dev or prod or qa etc. based on desired environment"
}

variable "instance_type" {
  type = string
  description = "To set desired instance type for AWS EC2 instance"
}

variable "ec2_user" {
  type = string
  description = "To set user for EC2 instance"
}

variable "private_key_file_path" {
  type = string
  description = "Private key file path for EC2 instance"
}