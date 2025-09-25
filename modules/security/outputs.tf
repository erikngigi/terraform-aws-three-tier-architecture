output "ec2_sg" {
  description = "Resource output for EC2 security group"
  value       = aws_security_group.ec2.id
}

output "ec2_ssh_key" {
  description = "Resource output for public SSH key"
  value       = aws_key_pair.public_key.id
}

output "mysql_rds_sg" {
  description = "Resource output for MySQL RDS security group"
  value       = aws_security_group.mysql_rds.id
}
