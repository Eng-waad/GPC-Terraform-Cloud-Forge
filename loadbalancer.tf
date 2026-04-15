# Health Check للتأكد من أن الأجهزة تعمل
resource "google_compute_health_check" "http_check" {
  name = "http-health-check"
  http_health_check {
    port = 80
  }
}

# Backend Service لربط الـ MIG بالـ Load Balancer
resource "google_compute_backend_service" "front_lb_service" {
  name          = "frontend-service"
  health_checks = [google_compute_health_check.http_check.id]
  backend {
    group = google_compute_instance_group_manager.front_mig.instance_group
  }
}

# URL Map لتوجيه الطلبات
resource "google_compute_url_map" "url_map" {
  name            = "web-map"
  default_service = google_compute_backend_service.front_lb_service.id
}

# HTTP Proxy
resource "google_compute_target_http_proxy" "http_proxy" {
  name    = "http-proxy"
  url_map = google_compute_url_map.url_map.id
}

# Global Forwarding Rule (هذا سيعطيكِ IP واحد ثابت للموقع بالكامل)
resource "google_compute_global_forwarding_rule" "default" {
  name       = "global-rule"
  target     = google_compute_target_http_proxy.http_proxy.id
  port_range = "80"
}