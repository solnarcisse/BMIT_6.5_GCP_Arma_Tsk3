# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork

#Iowa - Public
resource "google_compute_subnetwork" "subnet01" {
  name          = var.subnet01
  ip_cidr_range = var.cidr-public
  region        = var.vpcregion02
  network       = google_compute_network.vpc-arm.id
}

#South Africa - Private
resource "google_compute_subnetwork" "subnet02" {
  name                     = var.subnet02
  ip_cidr_range            = var.cidr-private
  region                   = var.vpcregion
  network                  = google_compute_network.vpc-arm.id
  private_ip_google_access = true
}
