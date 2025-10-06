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

resource "aws_instance" "magento1" {
  ami                         = data.aws_ami.ubuntu_latest.id
  instance_type               = var.ami_type
  associate_public_ip_address = false
  security_groups             = [var.ec2_sg]
  subnet_id                   = var.ec2_private_subnet_1
  iam_instance_profile        = var.ec2_ssm_profile

  tags = {
    Name = "${var.project_name}-1-ec2"
  }
}

resource "aws_instance" "magento2" {
  ami                         = data.aws_ami.ubuntu_latest.id
  instance_type               = var.ami_type
  associate_public_ip_address = false
  security_groups             = [var.ec2_sg]
  subnet_id                   = var.ec2_private_subnet_2
  iam_instance_profile        = var.ec2_ssm_profile

  tags = {
    Name = "${var.project_name}-2-ec2"
  }
}
