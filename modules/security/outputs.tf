output "ec2_sg" {
  description = "Resource output for EC2 security group"
  value       = aws_security_group.ec2.id
}

output "mysql_rds_sg" {
  description = "Resource output for MySQL RDS security group"
  value       = aws_security_group.mysql_rds.id
}

output "efs_sg" {
  description = "Resource output for the Elastic File System security group"
  value       = aws_security_group.efs.id
}

output "ec2_ssm_profile" {
  description = "Resource output for the EC2 ssm profile name"
  value       = aws_iam_instance_profile.ec2_ssm_role.name
}
