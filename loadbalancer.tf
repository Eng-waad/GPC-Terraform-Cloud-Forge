# Health Check ل
resource "google_compute_health_check" "http_check" {
  name = "http-health-check"
  http_health_check {
    port = 80
  }
}

# Backend Service - MIG - Load Balancer
resource "google_compute_backend_service" "front_lb_service" {
  name          = "frontend-service"
  health_checks = [google_compute_health_check.http_check.id]
  backend {
    group = google_compute_instance_group_manager.front_mig.instance_group
  }
}

# URL Map  
resource "google_compute_url_map" "url_map" {
  name            = "web-map"
  default_service = google_compute_backend_service.front_lb_service.id
}

# HTTP Proxy
resource "google_compute_target_http_proxy" "http_proxy" {
  name    = "http-proxy"
  url_map = google_compute_url_map.url_map.id
}

# Global Forwarding Rule 
resource "google_compute_global_forwarding_rule" "default" {
  name       = "global-rule"
  target     = google_compute_target_http_proxy.http_proxy.id
  port_range = "80"
}
