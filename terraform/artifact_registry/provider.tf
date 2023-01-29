provider "google" {
  project = var.project_id
  region  = "us-west1"
}

terraform {
  backend "gcs" {
    prefix = "dev/gcp-ide-cloud/artifact_registry"
    bucket = "shared-resources-tfstate"
  }
}
