output "mysql_rds_endpoint" {
  description = "MySQL RDS endpoint connection only in EC2"
  value       = aws_db_instance.mysql.endpoint
}
