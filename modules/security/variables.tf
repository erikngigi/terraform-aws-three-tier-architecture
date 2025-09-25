# Main details
variable "project_name" {
  description = "Name of the project for resource tagging"
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
    source_sg_ids = optional(list(string))
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

# Network
variable "vpc_id" {
  description = "Main VPC ID from network module"
  type        = string
}
