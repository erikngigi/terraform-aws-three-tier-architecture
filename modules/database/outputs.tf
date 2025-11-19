output "mysql_rds_endpoint" {
  description = "MySQL RDS endpoint connection only in EC2"
  value       = aws_db_instance.mysql.endpoint
}

output "mysql_rds_replica_endpoint" {
  description = "MySQL RDS Replica Endpoint connection only in EC2"
  value       = aws_db_instance.mysql_replica.endpoint
}
