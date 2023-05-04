resource "google_cloud_run_service" "ide_service" {
  name                       = "cloud-ide-server"
  location                   = var.region
  autogenerate_revision_name = true
  traffic {
    latest_revision = true
    percent         = 100
  }

  template {
    metadata {
      annotations = {
        "autoscaling.knative.dev/minScale"         = "0"
        "autoscaling.knative.dev/maxScale"         = "10"
        "run.googleapis.com/sessionAffinity"       = true
        "run.googleapis.com/execution-environment" = "gen2"
      }
    }
    spec {
      containers {
        image = "${var.region}-docker.pkg.dev/${var.project_id}/code-server-images/codeserver:latest"
        ports {
          container_port = 8080
        }
        resources {
          limits = {
            "cpu"    = "2000m"
            "memory" = "4Gi"
          }
        }
      }
      container_concurrency = 1
      timeout_seconds       = 300
      service_account_name  = "project-service-account@${var.project_id}.iam.gserviceaccount.com"

    }
  }
}

data "google_iam_policy" "noauth" {
  binding {
    role    = "roles/run.invoker"
    members = ["allUsers", ]
  }
}
resource "google_cloud_run_service_iam_policy" "noauth" {
  location = google_cloud_run_service.ide_service.location
  project  = google_cloud_run_service.ide_service.project
  service  = google_cloud_run_service.ide_service.name

  policy_data = data.google_iam_policy.noauth.policy_data
}




# https://cloud.google.com/run/docs/authenticating/end-users#internal
# https://cloud.google.com/run/docs/mapping-custom-domains
# https://cloud.google.com/iap/docs/enabling-cloud-run
