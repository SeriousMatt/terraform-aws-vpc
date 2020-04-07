provider "aws" {
  region = "us-east-1"
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = module.vpc.vpc_id
}

module "vpc" {
  source = "../../"

  name = "simple-vpc"

  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.101.0/24"]

  enable_ipv6 = true

  # enable_nat_gateway = true
  # single_nat_gateway = true

  public_subnet_tags = {
    Name = "simple-public-subnet"
  }

  tags = {
    Owner       = "user"
    Environment = "dev"
  }

  vpc_tags = {
    Name = "simple-vpc"
  }
}

