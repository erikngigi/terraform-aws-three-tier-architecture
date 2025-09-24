data "aws_ami" "ubuntu_latest" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.ami_name_pattern]
  }

  filter {
    name   = "virtualization-type"
    values = [var.ami_virtualization]
  }

  owners = [var.ami_owner_id]
}

resource "aws_instance" "odoo_instance" {
  ami                         = data.aws_ami.ubuntu_latest.id
  instance_type               = var.ami_type
  key_name                    = var.key_pair
  associate_public_ip_address = true
  security_groups             = [var.sg_id]
  subnet_id                   = var.pub_subnet_id

  tags = {
    Name = var.ec2_name
  }
}
