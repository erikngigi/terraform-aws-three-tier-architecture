output "ec2_instance_id_1" {
  description = "1st EC2 ID value"
  value       = aws_instance.magento1.id
}

output "ec2_instance_id_2" {
  description = "2nd EC2 ID value"
  value       = aws_instance.magento2.id
}
