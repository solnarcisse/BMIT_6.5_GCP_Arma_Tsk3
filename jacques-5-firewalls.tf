# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall

# Allow RDP
resource "google_compute_firewall" "app-rdp-allow" {
  name    = "${google_compute_network.app.name}-allow-rdp"
  network = google_compute_network.app.name

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["jacques-rdp-public"]
}

# Allow Internal Traffic
resource "google_compute_firewall" "app-allow-internal" {
  name    = "${google_compute_network.app.name}-allow-internal"
  network = google_compute_network.app.name
  #direction = "INGRESS" (not needed as it is 

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "22"]
  }

  source_tags = ["jacques-app-access"]
  target_tags = ["jacques-app-internal"]
}

# Allow Health Check
resource "google_compute_firewall" "allow_health_check" {
  name    = "${google_compute_network.app.name}-allow-health-check"
  network = google_compute_network.app.name


  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"] #change these
  target_tags   = ["jacques-app-internal"]
}
