terraform {
  backend "s3" {
    bucket         = "eric--bucket"
    key            = "terraform.tfstate"
    encrypt        = true
    dynamodb_table = "coalfire" #reuse this table
    profile        = "eric"
    region         = "us-east-2"
  }
}
provider "aws" {
  profile = "eric"
  region  = var.region
}
data "aws_availability_zones" "available" {
  state = "available"
}
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.17"
  name = "project-vpc"
  cidr = "10.0.0.0/16"

  azs             = data.aws_availability_zones.available.names
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  # Name your subnets
  public_subnet_names  = ["public-subnet-1", "public-subnet-2", "public-subnet-3"]
  private_subnet_names = ["private-subnet-1", "private-subnet-2", "private-subnet-3"]

  # enable_nat_gateway = true
    tags = {
    Terraform = "true"
    Environment = "dev"
  }

}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
version = "~> 20.31"

  cluster_name    = "myeks-cluster"
  cluster_version = "1.31"

  # access api server from outside the VPC
  cluster_endpoint_public_access = true

  # Optional: Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = true

  cluster_compute_config = {
    enabled    = true
    node_pools = ["general-purpose"]
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnets

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}