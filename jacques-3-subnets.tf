# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork

# Public Subnet
resource "google_compute_subnetwork" "app-public" {
  name                     = "app-public"
  ip_cidr_range            = var.subnet_ip_cidr_range_public
  region                   = var.region_a
  network                  = google_compute_network.app.id
  private_ip_google_access = true # Enable Private Google Access if needed
}

# Private Subnet
resource "google_compute_subnetwork" "app-private" {
  name                     = "app-private"
  ip_cidr_range            = var.subnet_ip_cidr_range_private
  region                   = var.region_b
  network                  = google_compute_network.app.id
  private_ip_google_access = true
}
