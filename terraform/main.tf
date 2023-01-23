resource "google_artifact_registry_repository" "vscodeserver-images-repo" {
  repository_id = "vscode-server-images"
  location      = "us-west4"
  format        = "DOCKER"
  description   = "A docker repository for all the vscodeserver images"
}


resource "google_cloud_run_service" "ide_service" {
  name                       = "cloud-ide-server"
  location                   = "us-west1"
  autogenerate_revision_name = true

  traffic {
    latest_revision = true
    percent         = 100
  }

  template {
    metadata {
      annotations = {
        "autoscaling.knative.dev/minScale" = "0"
        "autoscaling.knative.dev/maxScale" = "10"
      }
    }
    spec {
      containers {
        image = "us-west4-docker.pkg.dev/gcp-ide-cloud-chp001-5cbc/vscode-server-images/codeserver:latest"
        ports {
          container_port = 8080
        }
      }
      timeout_seconds      = 120
      service_account_name = ""

    }
  }
}

# https://cloud.google.com/run/docs/authenticating/end-users#internal
# https://cloud.google.com/run/docs/mapping-custom-domains
# https://cloud.google.com/iap/docs/enabling-cloud-run

# resource "aws_route53_record" "cloud_ide_dns_record" {
#   provider = aws.route53
# }
