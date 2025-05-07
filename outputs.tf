output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = module.public_network.public_subnet_id
}

output "private_subnet_id" {
  description = "ID of the private subnet"
  value       = module.private_network.private_subnet_id
}

output "app_server_id" {
  description = "ID of the app server instance"
  value       = module.ec2.app_server_id
}

output "db_server_id" {
  description = "ID of the database server instance"
  value       = module.ec2.db_server_id
}