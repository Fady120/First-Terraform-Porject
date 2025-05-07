variable "public_subnet_id" {
  description = "ID of the public subnet"
  type        = string
}

variable "private_subnet_id" {
  description = "ID of the private subnet"
  type        = string
}

variable "public_sg_id" {
  description = "ID of the public security group"
  type        = string
}

variable "private_sg_id" {
  description = "ID of the private security group"
  type        = string
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
}

variable "app_server_ami" {
  description = "AMI ID for the app server"
  type        = string
  default     = "ami-0dd574ef87b79ac6c"
}

variable "db_server_ami" {
  description = "AMI ID for the database server"
  type        = string
  default     = "ami-0dd574ef87b79ac6c"
}

variable "app_server_instance_type" {
  description = "Instance type for the app server"
  type        = string
  default     = "t3.micro"
}

variable "db_server_instance_type" {
  description = "Instance type for the database server"
  type        = string
  default     = "t3.micro"
}

variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}