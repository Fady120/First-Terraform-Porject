output "app_server_id" {
  description = "ID of the app server instance"
  value       = aws_instance.app_server.id
}

output "db_server_id" {
  description = "ID of the database server instance"
  value       = aws_instance.database_server.id
}