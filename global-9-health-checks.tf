# Health check (global)
resource "google_compute_health_check" "http" {
  name = "${var.app_name}-http-hc"
  http_health_check {
    port_specification = "USE_SERVING_PORT"
  }
}

# TSA Health Check
resource "google_compute_health_check" "tsa-health-check" {
  name = "tsa-health-check"

  http_health_check {
    port         = 80
    request_path = "/"
  }

  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 3
}