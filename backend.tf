terraform {
  backend "s3" {
    bucket = "harit-terraform-state-ap-south-1"
    key    = "env-dev-free-tier/terraform.tfstate"
    region = "ap-south-1"
  }
}