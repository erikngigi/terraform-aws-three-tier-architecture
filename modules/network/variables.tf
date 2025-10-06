# Main details
variable "project_name" {
  description = "Name of the project for resource tagging"
  type        = string
}

# Networking
variable "vpc_cidr" {
  description = "VPC CIDR value"
  type        = string
}

variable "target_alb_port" {
  description = "Target port for the Application load balancer"
  type        = string
}

# Security
variable "ec2_sg" {
  description = "EC2 security group from security module"
  type        = string
}

# Instance
variable "ec2_instance_id_1" {
  description = "1st EC2 ID value (instance module)"
  type        = string
}

variable "ec2_instance_id_2" {
  description = "2nd EC2 ID value (instance module)"
  type        = string
}
