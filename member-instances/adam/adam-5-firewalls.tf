# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall

# Allow RDP ONLY to Windows VM
resource "google_compute_firewall" "rdp01" {
  name    = var.rdp01
  network = google_compute_network.vpc-arm.name

  direction = "INGRESS"
  priority  = 1000

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["rdp-public"]
}

# Allow Internal Traffic
resource "google_compute_firewall" "internal01" {
  name    = var.internal01
  network = google_compute_network.vpc-arm.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "22"]
  }

  source_tags = ["rdp-public"]
  target_tags = ["southafrica"]
}

# Allow Health Check
resource "google_compute_firewall" "healthcheck01" {
  name    = var.healthcheck01
  network = google_compute_network.vpc-arm.name

  direction = "INGRESS"
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["35.191.0.0/16", "130.211.0.0/22"]
  target_tags   = ["southafrica"]
}