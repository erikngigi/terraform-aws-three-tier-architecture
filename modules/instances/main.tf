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

resource "aws_instance" "magento" {
  ami                         = data.aws_ami.ubuntu_latest.id
  instance_type               = var.ami_type
  key_name                    = var.ec2_ssh_key
  associate_public_ip_address = true
  security_groups             = [var.ec2_sg]
  subnet_id                   = var.public_subnet

  tags = {
    Name = "${var.project_name}-ec2"
  }
}
