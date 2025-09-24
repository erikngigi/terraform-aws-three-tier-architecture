# Networking
variable "vpc_cidr_block" {
  description = "VPC CIDR value"
  type        = string
}

variable "vpc_cidr_block_name" {
  description = "VPC CIDR name"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "Public Subnet CIDR values"
  type        = string
}

variable "public_subnet_cidrs_name" {
  description = "Public Subnet name"
  type        = string
}

variable "private_subnet_cidrs_name" {
  description = "Private Subnet name"
  type        = string
}

variable "private_subnet_cidrs" {
  description = "Private Subnet CIDR values"
  type        = string
}

variable "azs" {
  description = "Availability Zones"
  type        = string
}

variable "igw_name" {
  description = "Internet Gateway name"
  type        = string
}

variable "irt_name" {
  description = "Internet Route Table name"
  type        = string
}

# Security
variable "ssh_pub_key" {
  description = "Public SSH Key for the EC2 instance"
  type        = string
}

variable "ssh_pub_key_name" {
  description = "Public SSH Key Name"
  type        = string
}

variable "sg_name" {
  description = "Security Group name"
  type        = string
}

variable "sg_description" {
  description = "Security Group for Odoo"
  type        = string
}

variable "ig_rules" {
  description = "Inbound Security Rules"
  type = map(object({
    description   = string
    port          = number
    protocol      = string
    sg_cidr_block = list(string)
  }))
}

variable "eg_rules" {
  description = "Outbound Security Rules"
  type = map(object({
    description   = string
    port          = number
    protocol      = string
    sg_cidr_block = list(string)
  }))
}

# EC2
variable "ami_name_pattern" {
  description = "AMI name pattern"
  type        = string
  default     = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
}

variable "ami_virtualization" {
  description = "Virtualization type for the EC2 AMI"
  type        = string
  default     = "hvm"
}

variable "ami_owner_id" {
  description = "AWD Account ID for the AMI"
  type        = string
  default     = "099720109477"
}

variable "ami_type" {
  description = "Instance type for AMI"
  type        = string
}

variable "ec2_name" {
  description = "Name to assign to the EC2 instance"
  type        = string
}
