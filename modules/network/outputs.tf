output "vpc_id" {
  description = "Resource output for the VPC ID."
  value       = aws_vpc.main.id
}

output "ec2_private_subnet_1" {
  description = "Private subnet value for the first EC2 instances"
  value       = aws_subnet.private_subnet[0].id
}

output "ec2_private_subnet_2" {
  description = "Private subnet value for the second EC2 instances"
  value       = aws_subnet.private_subnet[1].id
}

output "efs_private_subnet_1" {
  description = "First private subnet value for the EFS"
  value       = aws_subnet.private_subnet[4].id
}

output "efs_private_subnet_2" {
  description = "Second private subnet value for the EFS"
  value       = aws_subnet.private_subnet[5].id
}

output "mysql_rds_subnet" {
  description = "Resource output for the MySQL RDS subnet group"
  value       = aws_db_subnet_group.mysql_rds_subnet.name
}

output "alb_dns_name" {
  description = "Public DNS name of the Application Load Balancer"
  value       = aws_lb.app_loadbalancer.dns_name
}
