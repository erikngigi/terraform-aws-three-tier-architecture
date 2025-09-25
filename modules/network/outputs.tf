output "vpc_id" {
  description = "Resource output for the VPC ID."
  value       = aws_vpc.main.id
}

output "public_subnet" {
  description = "Resource output for the public subnet values"
  value       = aws_subnet.public_subnet[0].id
}

output "mysql_rds_subnet" {
  description = "Resource output for the MySQL RDS subnet group"
  value       = aws_db_subnet_group.mysql_rds_subnet.name
}
