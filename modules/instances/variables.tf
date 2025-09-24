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

variable "pub_subnet_id" {
  description = "Public Subnet ID (network module)"
  type        = string
}

variable "sg_id" {
  description = "Security Group ID (security module)"
  type        = string
}

variable "key_pair" {
  description = "Public SSH Key ID (security module)"
}
