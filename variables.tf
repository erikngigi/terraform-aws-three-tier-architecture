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

# Security
variable "ssh_pub_key" {
  description = "Public SSH Key for the EC2 instance"
  type        = string
}

variable "ec2_ingress" {
  description = "Application Load Balancer inbound rules"
  type = map(object({
    description   = string
    port          = number
    protocol      = string
    sg_cidr_block = list(string)
  }))
}

variable "ec2_egress" {
  description = "Application Load Balancer outbound rules"
  type = map(object({
    description   = string
    port          = number
    protocol      = string
    sg_cidr_block = list(string)
  }))
}

variable "mysql_rds_ingress" {
  description = "MySQL RDS inbound rules"
  type = map(object({
    description = string
    port        = number
    protocol    = string
  }))
}

variable "mysql_rds_egress" {
  description = "MySQL RDS outbound rules"
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

# Databases
variable "rds_engine" {
  description = "Relation Database Engine to implement"
  type        = string
}

variable "rds_engine_version" {
  description = "Relation Database Engine version to implement"
  type        = string
}

variable "rds_instance_class" {
  description = "Instance class for RDS"
  type        = string
}

variable "allocated_storage" {
  description = "Allocated storage size for the RDS"
  type        = string
}

variable "rds_username" {
  description = "RDS username"
  type = string
}

variable "rds_password" {
  description = "RDS user password"
  type = string
}
