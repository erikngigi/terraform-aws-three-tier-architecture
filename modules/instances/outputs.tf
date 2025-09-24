output "ec2_pub_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.odoo_instance.public_ip
}
