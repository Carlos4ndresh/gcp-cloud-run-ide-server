resource "google_artifact_registry_repository" "vscodeserver-images-repo" {
  repository_id = "vscode-server-images"
  location      = "us-west4"
  format        = "DOCKER"
  description   = "A docker repository for all the vscodeserver images"
}
