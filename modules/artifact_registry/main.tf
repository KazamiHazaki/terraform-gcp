resource "google_artifact_registry_repository" "my-repo" {
  location      = var.registry_location
  repository_id = var.registry_name
  description   = "Docker repository"
  format        = "DOCKER"
}
