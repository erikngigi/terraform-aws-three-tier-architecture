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

variable "private_subnet_cidrs" {
  description = "Private Subnet CIDR values"
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
