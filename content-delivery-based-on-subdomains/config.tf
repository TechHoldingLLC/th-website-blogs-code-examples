terraform {
  backend "local" {}
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

provider "aws" {
  alias   = "us-east-1"
  region  = "us-east-1"
  profile = var.aws_profile
}

terraform {
  required_version = "= 1.9.8"

  required_providers {
    aws  = "= 5.81.0"
    null = ">= 2.1"
  }
}