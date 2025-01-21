provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

provider "google-beta" {
  alias   = "google-beta"
  project = var.gcp_project_id
  region  = var.gcp_region
}

terraform {
  required_version = ">= 1.7.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.40.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "6.6.0"
    }
  }
}
