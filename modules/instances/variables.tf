# Main details
variable "project_name" {
  description = "Name of the project for resource tagging"
  type        = string
}

# Instance details
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

# Imported details
# Network details
variable "ec2_private_subnet_1" {
  description = "1st EC2 private subnet value (network module)"
  type        = string
}

variable "ec2_private_subnet_2" {
  description = "2nd EC2 private subnet value (network module)"
  type        = string
}

# Security details
variable "ec2_sg" {
  description = "EC2 security group from the security module"
  type        = string
}

variable "ec2_ssm_profile" {
  description = "EC2 ssm profile name from the security module"
  type        = string
}
