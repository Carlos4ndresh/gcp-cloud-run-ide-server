resource "google_compute_global_address" "lb_address" {
  name        = "global-address-code-ide-service-lb"
  description = "Global IP address for the HTTPS load balancer for the IDE service"
  ip_version  = "IPV4"
}

resource "google_compute_region_network_endpoint_group" "cloud_run_ide_neg" {
  name                  = "code-ide-lb-neg"
  network_endpoint_type = "SERVERLESS"
  region                = "us-west1"
  cloud_run {
    service = google_cloud_run_service.ide_service.name
  }
}


resource "google_compute_backend_service" "code_ide_backend" {
  name                  = "code-ide-backend-svc"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  backend {
    group = google_compute_region_network_endpoint_group.cloud_run_ide_neg.id
  }
}

resource "google_compute_url_map" "code_service_urlmap" {
  name        = "code-service-urlmap"
  description = "All possible routes; future versions will leverage on different routes"
  host_rule {
    hosts        = ["coder.uselessnerd.com"]
    path_matcher = "codersite"
  }
  path_matcher {
    name            = "codersite"
    default_service = google_compute_backend_service.code_ide_backend.id
    path_rule {
      service = google_compute_backend_service.code_ide_backend.id
      paths   = ["/beta", "/coder"]
    }
  }
  default_url_redirect {
    host_redirect = "www.carlosaherrera.com"
    strip_query   = true
  }
}

resource "google_compute_managed_ssl_certificate" "site_cert" {
  name = "coder-cert"
  managed {
    domains = ["coder.uselessnerd.com"]
  }
}

resource "google_compute_target_https_proxy" "default_proxy" {
  name             = "coder-proxy"
  url_map          = google_compute_url_map.code_service_urlmap.id
  ssl_certificates = [google_compute_managed_ssl_certificate.site_cert.id]
}

resource "google_compute_global_forwarding_rule" "default_forwarding_rule" {
  name                  = "coder-forwarding-rule"
  target                = google_compute_target_https_proxy.default_proxy.id
  ip_address            = google_compute_global_address.lb_address.id
  port_range            = "443"
  load_balancing_scheme = "EXTERNAL_MANAGED"
}
