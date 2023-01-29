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
        image = "us-west4-docker.pkg.dev/${var.project_id}/vscode-server-images/codeserver:0.1"
        ports {
          container_port = 8080
        }
        resources {
          limits = {
            "cpu"    = "2000m"
            "memory" = "2Gi"
          }
        }
      }
      container_concurrency = 1
      timeout_seconds       = 120
      service_account_name  = "project-service-account@${var.project_id}.iam.gserviceaccount.com"

    }
  }
}

# https://cloud.google.com/run/docs/authenticating/end-users#internal
# https://cloud.google.com/run/docs/mapping-custom-domains
# https://cloud.google.com/iap/docs/enabling-cloud-run

# resource "aws_route53_record" "cloud_ide_dns_record" {
#   provider = aws.route53
# }
