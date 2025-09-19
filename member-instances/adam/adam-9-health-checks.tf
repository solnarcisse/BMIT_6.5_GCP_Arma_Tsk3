# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_health_check

# Health Check
resource "google_compute_health_check" "apps-hc" {
  name = var.apps-hc
  http_health_check {
    port = 80
  }
}

# TSA Health Check
resource "google_compute_health_check" "apps-tsa-hc" {
  name = var.apps-tsa-hc

  http_health_check {
    port         = 80
    request_path = "/"
  }

  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 3
}