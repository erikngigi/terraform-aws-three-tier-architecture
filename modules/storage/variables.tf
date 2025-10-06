# Main details
variable "project_name" {
  description = "Name of the project for resource tagging"
  type        = string
}

# Network
variable "efs_private_subnet_1" {
  description = "1st private subnet value for EFS (network module)"
  type        = string
}

variable "efs_private_subnet_2" {
  description = "2nd private subnet value for EFS (network module)"
  type        = string
}

# Security
variable "efs_security_group" {
  description = "EFS security group (security module)"
  type        = string
}
