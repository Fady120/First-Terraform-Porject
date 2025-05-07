terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket       = "fedo-terraform-backend"
    key          = "terraform.tfstate"
    region       = "eu-north-1"
    encrypt      = true
    use_lockfile = true
  }
}

module "vpc" {
  source = "./modules/vpc"
}

module "public_network" {
  source = "./modules/public-network"

  vpc_id      = module.vpc.vpc_id
  name_prefix = var.name_prefix
}

module "private_network" {
  source = "./modules/private-network"

  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.public_network.public_subnet_id
  name_prefix      = var.name_prefix
  igw_dependency   = module.public_network.internet_gateway
}

module "ec2" {
  source = "./modules/ec2"

  public_subnet_id  = module.public_network.public_subnet_id
  private_subnet_id = module.private_network.private_subnet_id
  public_sg_id      = module.public_network.public_sg_id
  private_sg_id     = module.private_network.private_sg_id
  key_name          = var.key_name
  name_prefix       = var.name_prefix
}