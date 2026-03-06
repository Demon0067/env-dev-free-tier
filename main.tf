provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source = "git::https://github.com/Demon0067/tf-mod-vpc-min.git?ref=v1.0"
}

module "ec2" {
  source = "git::https://github.com/Demon0067/tf-mod-ec2-ssm.git?ref=v1.0"

  vpc_id    = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnet_id
}