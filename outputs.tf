output "ec2_ipv4_address" {
  value = module.instance.ec2_ipv4_address
}

output "mysql_rds_endpoint" {
  value = module.database.mysql_rds_endpoint
}
