output "ec2_instance_id_1" {
  description = "ID value of the 1st EC2 instance created"
  value       = module.instance.ec2_instance_id_1
}

output "ec2_instance_id_2" {
  description = "ID value of the 2nd EC2 instance created"
  value       = module.instance.ec2_instance_id_2
}

output "mysql_rds_endpoint" {
  description = "MySQL RDS endpoint value"
  value       = module.database.mysql_rds_endpoint
}

output "mysql_rds_replica_endpoint" {
  description = "MySQL RDS Replica endpoint value"
  value       = module.database.mysql_rds_replica_endpoint
}

output "efs_dns_name" {
  description = "DNS hostname of the EFS"
  value       = module.storage.efs_dns_hostname
}

output "alb_dns_name" {
  description = "Public DNS name of the Application Load Balancer"
  value       = module.network.alb_dns_name
}
