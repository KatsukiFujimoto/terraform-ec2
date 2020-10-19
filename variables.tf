variable "access_key" {}
variable "secret_key" {}
variable "db_username" {}
variable "db_password" {}

variable "project" {
  type    = string
  default = "terraform-ec2"
}

variable "env" {
  type    = string
  default = "dev"
}

variable "vpc_cidr" {
  type = map(string)
  default = {
    dev = "10.1.0.0/16"
  }
}

variable "subnet_cidr" {
  type = map(string)
  default = {
    dev_public_a  = "10.1.1.0/24"
    dev_public_c  = "10.1.2.0/24"
    dev_private_a = "10.1.3.0/24"
    dev_private_c = "10.1.4.0/24"
  }
}

variable "key_pair" {
  type    = string
  default = "aws-tutorial" # should be created before
}

variable "az" {
  type = map(string)
  default = {
    az_a = "ap-northeast-1a"
    az_c = "ap-northeast-1c"
    az_d = "ap-northeast-1d"
  }
}

variable "domain" {
  type = map(string)
  default = {
    dev = "aws-tutorial.gq"
  }
}
