variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-north-1"
}

variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "dev"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "pink+white1"
}