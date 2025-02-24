terraform {
  backend "local" {}
}

provider "aws" {
  region  = "aws_region"
  profile = "aws_profile_name"
}

terraform {
  required_version = "= 1.9.8"

  required_providers {
    aws  = "= 5.81.0"
    null = ">= 2.1"
  }
}