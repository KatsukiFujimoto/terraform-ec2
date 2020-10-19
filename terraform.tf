terraform {
  backend "s3" {
    bucket     = "aws-ec2-terraform-tutorial" # should be created before
    key        = "dev/terraform.tfstate"
    region     = "ap-northeast-1"
    access_key = var.access_key
    secret_key = var.secret_key
  }
}

provider "aws" {
  region     = "ap-northeast-1"
  access_key = var.access_key
  secret_key = var.secret_key
}
