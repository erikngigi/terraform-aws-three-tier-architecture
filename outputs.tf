output "ec2_instance_id1" {
  value = module.instance.ec2_instance_id1
}

output "ec2_instance_id2" {
  value = module.instance.ec2_instance_id2
}

output "mysql_rds_endpoint" {
  value = module.database.mysql_rds_endpoint
}
