provider "google" {
  project = var.project_id
  region  = var.region
}

terraform {
  backend "gcs" {
    prefix = "dev/gcp-ide-cloud/artifact_registry"
    bucket = "shared-resources-tfstate"
  }
}
