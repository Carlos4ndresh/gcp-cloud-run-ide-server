provider "google" {
  project = var.project_id
  region  = "us-west1"
}

terraform {
  backend "gcs" {
    prefix = "dev/gcp-ide-cloud/cloud_run"
    bucket = "shared-resources-tfstate"
  }
}

provider "aws" {
  alias  = "route53"
  region = "us-east-1"
}
