output "ec2_config_bucket_arn" {
  description = "Resource output of the ARN of the S3 bucket containing configuration files"
  value       = aws_s3_bucket.ec2_config.arn
}

output "efs_dns_hostname" {
  description = "Resource output for the DNS hostname of the EFS"
  value       = aws_efs_mount_target.efs_mount_target_1.dns_name
}
