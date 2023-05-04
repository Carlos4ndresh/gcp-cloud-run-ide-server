provider "google" {
  project = var.project_id
  region  = var.region
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
