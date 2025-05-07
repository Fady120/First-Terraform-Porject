resource "aws_instance" "app_server" {
  ami                         = var.app_server_ami
  instance_type               = var.app_server_instance_type
  subnet_id                   = var.public_subnet_id
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.public_sg_id]
  key_name                    = var.key_name

  user_data = templatefile("${path.module}/templates/app_server_user_data.sh", {
    db_host = aws_instance.database_server.private_ip
  })

  tags = {
    Name = "${var.name_prefix}-app-server"
  }
}

resource "aws_instance" "database_server" {
  ami                         = var.db_server_ami
  instance_type               = var.db_server_instance_type
  subnet_id                   = var.private_subnet_id
  associate_public_ip_address = false
  vpc_security_group_ids      = [var.private_sg_id]
  key_name                    = var.key_name

  user_data = file("${path.module}/templates/db_server_user_data.sh")

  tags = {
    Name = "${var.name_prefix}-db-server"
  }
}