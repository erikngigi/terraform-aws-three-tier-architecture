output "ec2_ipv4_address" {
  description = "Public IPv4 address from the EC2"
  value       = aws_instance.magento.public_ip
}
