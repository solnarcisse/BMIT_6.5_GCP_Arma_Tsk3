# 1) Allow RDP ONLY to instances with the rdp-public tag (Windows VM)
resource "google_compute_firewall" "allow_rdp_public" {
  name    = "${var.app_name}-allow-rdp-public"
  network = google_compute_network.vpc.name

  direction = "INGRESS"
  target_tags = ["rdp-public"]

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = ["0.0.0.0/0"] # narrow this to corporate IPs if you can
  description   = "RDP allowed only to public-region Windows via tag"
}

# 2) Allow Windows -> Linux (egress from Windows to Linux target tags) (HTTP and SSH)
resource "google_compute_firewall" "egress_windows_to_linux" {
  name    = "${var.app_name}-egress-windows-to-linux"
  network = google_compute_network.vpc.name

  direction   = "EGRESS"
  target_tags = ["windows"]               # the Windows VM tag
  destination_ranges = ["10.10.0.0/15"]   # narrow if you split further; covers 10.10.0.0/15

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }

  description = "Windows VM can reach Linux VMs and ILB backends"
}

# 3) Allow ILB proxies to reach Linux backends (source = proxy-only subnets; port 80)
# Backends see connections from proxy-only ranges (not from client IPs).
resource "google_compute_firewall" "allow_ilb_proxies_to_backends" {
  name    = "${var.app_name}-allow-ilb-proxies"
  network = google_compute_network.vpc.name

  direction   = "INGRESS"
  # Target = all member tags (one per Linux VM) — added below via dynamic block in members/*.tf
  # We'll create one rule per member from members/*.tf so each rule targets just that member tag.

  # This file intentionally left without targets to avoid referencing unknown locals here.
  # See members/*.tf for per-member firewall rules.
}
