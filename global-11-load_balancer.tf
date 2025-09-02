

# Global backend service for cross-region internal ALB (backends added from members/*)
resource "google_compute_backend_service" "ilb_backend" {
  name                  = "${var.app_name}-ilb-backend"
  protocol              = "HTTP"
  load_balancing_scheme = "INTERNAL_MANAGED"
  health_checks         = [google_compute_health_check.http.id]
  timeout_sec           = 30

  connection_draining_timeout_sec = 0

  backend {
    group           = google_compute_region_instance_group_manager.brazil.instance_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
    max_utilization = 0.8
  }

  #health_checks = [google_compute_health_check.tsa-health-check.self_link]
}

# Global URL map and target proxy
resource "google_compute_url_map" "ilb_map" {
  name            = "${var.app_name}-ilb-map"
  default_service = google_compute_backend_service.ilb_backend.id
}

resource "google_compute_target_http_proxy" "ilb_proxy" {
  name    = "${var.app_name}-ilb-proxy"
  url_map = google_compute_url_map.ilb_map.id
}

# Regional forwarding rule for the ILB VIP (choose the private region)
resource "google_compute_forwarding_rule" "ilb_fwd" {
  name                  = "${var.app_name}-ilb-fr"
  region                = var.private_region
  load_balancing_scheme = "INTERNAL_MANAGED"
  network               = google_compute_network.vpc.id
  subnetwork            = google_compute_subnetwork.private.id
  target                = google_compute_target_http_proxy.ilb_proxy.id
  port_range            = "80"
  ip_protocol           = "TCP"
}
