# Main details
variable "project_name" {
  description = "Name of the project for resource tagging"
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
  type        = string
}

variable "rds_password" {
  description = "RDS user password"
  type        = string
}

# Security
variable "mysql_rds_security_group" {
  description = "MySQL RDS security group from security module"
  type        = string
}

# Network
variable "mysql_rds_subnet_group" {
  description = "MySQL RDS private subnet group"
  type        = string
}
