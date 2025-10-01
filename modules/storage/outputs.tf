output "ec2_config_bucket_arn" {
  description = "Resource output of the ARN of the S3 bucket containing configuration files"
  value       = aws_s3_bucket.ec2_config.arn
}
