resource "aws_s3_bucket" "ec2_config" {
  bucket = "${var.project_name}-ec2-config"

  tags = {
    Name = "${var.project_name}-ec2-config"
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
