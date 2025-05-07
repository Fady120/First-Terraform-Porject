output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public_subnet.id
}

output "public_sg_id" {
  description = "ID of the public security group"
  value       = aws_security_group.public_sg.id
}

output "internet_gateway" {
  description = "Internet Gateway resource"
  value       = aws_internet_gateway.internet_gateway
}