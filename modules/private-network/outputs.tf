output "private_subnet_id" {
  description = "ID of the private subnet"
  value       = aws_subnet.private_subnet.id
}

output "private_sg_id" {
  description = "ID of the private security group"
  value       = aws_security_group.private_sg.id
}