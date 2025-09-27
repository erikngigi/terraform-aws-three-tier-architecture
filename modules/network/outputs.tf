output "vpc_id" {
  description = "Resource output for the VPC ID."
  value       = aws_vpc.main.id
}

output "private_subnet_1" {
  description = "Resource output for the private subnet values for ec2"
  value       = aws_subnet.private_subnet[0].id
}

output "private_subnet_2" {
  description = "Resource output for the private subnet values for ec2"
  value       = aws_subnet.private_subnet[1].id
}

output "mysql_rds_subnet" {
  description = "Resource output for the MySQL RDS subnet group"
  value       = aws_db_subnet_group.mysql_rds_subnet.name
}
