

output "cloud_run_url_internal" {
  value = [for s in google_cloud_run_service.ide_service.status : s.url]
}
