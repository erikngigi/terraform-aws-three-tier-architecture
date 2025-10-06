resource "aws_s3_bucket" "ec2_config" {
  bucket = "${var.project_name}-s3-configuration"

  tags = {
    Name = "${var.project_name}-s3-configuration"
  }
}

resource "aws_s3_bucket_ownership_controls" "ec2_config" {
  bucket = aws_s3_bucket.ec2_config.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "ec2_config" {
  depends_on = [aws_s3_bucket_ownership_controls.ec2_config]

  bucket = aws_s3_bucket.ec2_config.id
  acl    = "private"
}

resource "aws_s3_object" "ec2_config" {
  for_each = fileset("${path.root}/cloud-init", "**")

  bucket = aws_s3_bucket.ec2_config.id
  key    = each.value
  source = "${path.root}/cloud-init/${each.value}"
  etag   = filemd5("${path.root}/cloud-init/${each.value}")
}

resource "aws_efs_file_system" "efs_file_system" {
  creation_token   = "${var.project_name}-efs"
  performance_mode = "generalPurpose"

  tags = {
    Name = "${var.project_name}-efs"
  }
}

resource "aws_efs_mount_target" "efs_mount_target_1" {
  file_system_id  = aws_efs_file_system.efs_file_system.id
  subnet_id       = var.efs_private_subnet_1
  security_groups = [var.efs_security_group]
}

resource "aws_efs_mount_target" "efs_mount_target_2" {
  file_system_id  = aws_efs_file_system.efs_file_system.id
  subnet_id       = var.efs_private_subnet_2
  security_groups = [var.efs_security_group]
}
