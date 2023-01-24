provider "google" {
  project = "gcp-ide-cloud-chp001-5cbc"
  region  = "us-west1"
}

terraform {
  backend "gcs" {
    prefix = "dev/gcp-ide-cloud"
    bucket = "shared-resources-tfstate"
  }
}

provider "aws" {
  alias  = "route53"
  region = "us-east-1"
}
