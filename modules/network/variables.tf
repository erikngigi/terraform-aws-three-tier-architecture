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
variable "ec2_instance_id1" {
  description = "EC2 instance ID 1 from instance module"
  type        = string
}

variable "ec2_instance_id2" {
  description = "EC2 instance ID 2 from instance module"
  type        = string
}
