resource "aws_security_group" "ec2" {
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.ec2_ingress
    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.sg_cidr_block
    }
  }

  dynamic "egress" {
    for_each = var.ec2_egress
    content {
      description = egress.value.description
      from_port   = egress.value.port
      to_port     = egress.value.port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.sg_cidr_block
    }
  }

  tags = {
    Name = "${var.project_name}-ec2-security-group"
  }
}

resource "aws_security_group" "mysql_rds" {
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.mysql_rds_ingress
    content {
      description     = ingress.value.description
      from_port       = ingress.value.port
      to_port         = ingress.value.port
      protocol        = ingress.value.protocol
      security_groups = [aws_security_group.ec2.id]
    }
  }

  dynamic "egress" {
    for_each = var.mysql_rds_egress
    content {
      description = egress.value.description
      from_port   = egress.value.port
      to_port     = egress.value.port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.sg_cidr_block
    }
  }
}

resource "aws_key_pair" "public_key" {
  key_name   = "${var.project_name}-ssh-public-key"
  public_key = file(var.ssh_pub_key)
}

resource "aws_iam_role" "ec2_ssm_role" {
  name = "${var.project_name}-ec2-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "s3_access" {
  name = "${var.project_name}-s3-policy"
  role = aws_iam_role.ec2_ssm_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = ["s3:GetObject", "s3:ListAllMyBuckets", "s3:ListBucket"]
      Resource = [
        var.ec2_config_bucket_arn,
        "${var.ec2_config_bucket_arn}/*"
      ]
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_core" {
  role       = aws_iam_role.ec2_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ec2_ssm_role" {
  name = "${var.project_name}-ec2-ssm-profile"
  role = aws_iam_role.ec2_ssm_role.name
}
