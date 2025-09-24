output "sg" {
  description = "Security Group ID"
  value       = aws_security_group.sg.id
}

output "key_pair" {
  description = "Public SSH Key ID"
  value       = aws_key_pair.public_key.id
}
