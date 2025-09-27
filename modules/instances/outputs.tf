output "ec2_instance_id1" {
  description = "EC2 instance ID 1"
  value       = aws_instance.magento1.id
}

output "ec2_instance_id2" {
  description = "EC2 instance ID 2"
  value       = aws_instance.magento2.id
}
