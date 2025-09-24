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

variable "vpc_id" {
  description = "VPC ID value"
  type        = string
}
