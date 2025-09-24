resource "aws_security_group" "sg" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ig_rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.sg_cidr_block
    }
  }

  dynamic "egress" {
    for_each = var.eg_rules
    content {
      description = egress.value.description
      from_port   = egress.value.port
      to_port     = egress.value.port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.sg_cidr_block
    }
  }

  tags = {
    Name = var.sg_name
  }
}

resource "aws_key_pair" "public_key" {
  key_name   = var.ssh_pub_key_name
  public_key = file(var.ssh_pub_key)
}
