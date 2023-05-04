resource "google_artifact_registry_repository" "vscodeserver-images-repo" {
  repository_id = "code-server-images"
  location      = var.region
  format        = "DOCKER"
  description   = "A docker repository for all the vscodeserver images"
}
