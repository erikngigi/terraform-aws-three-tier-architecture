output "ec2_instance_id_1" {
  description = "ID value of the 1st EC2 instance created"
  value       = "Instance 1 ID: ${module.instance.ec2_instance_id_1}"
}

output "ec2_instance_id_2" {
  description = "ID value of the 2nd EC2 instance created"
  value       = "Instance 2 ID: ${module.instance.ec2_instance_id_2}"
}

output "mysql_rds_endpoint" {
  description = "MySQL RDS endpoint value"
  value       = "MySQL RDS Endpoint: ${module.database.mysql_rds_endpoint}"
}

output "efs_dns_name" {
  description = "DNS hostname of the EFS"
  value       = "EFS DNS Hostname: ${module.storage.efs_dns_hostname}"
}
