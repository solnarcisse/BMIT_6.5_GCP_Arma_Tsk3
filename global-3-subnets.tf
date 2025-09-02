# Subnet for public region (Windows client)
resource "google_compute_subnetwork" "public" {
  name          = "${var.vpc_name}-${var.public_region}"
  ip_cidr_range = var.cidr_public
  region        = var.public_region
  network       = google_compute_network.vpc.id
}

# Subnet for private region (one ILB VIP + some backends; more backends can be in other regions)
resource "google_compute_subnetwork" "private" {
  name          = "${var.vpc_name}-${var.private_region}"
  ip_cidr_range = var.cidr_private
  region        = var.private_region
  network       = google_compute_network.vpc.id
}

# Proxy-only subnets required for internal Application LB (one per region you use with ILB)
# Cross-region ILB requires purpose GLOBAL_MANAGED_PROXY
resource "google_compute_subnetwork" "proxy_public" {
  name          = "${var.vpc_name}-proxy-${var.public_region}"
  ip_cidr_range = var.cidr_proxy_pub
  region        = var.public_region
  network       = google_compute_network.vpc.id
  purpose       = "GLOBAL_MANAGED_PROXY"
  role          = "ACTIVE"
}

resource "google_compute_subnetwork" "proxy_private" {
  name          = "${var.vpc_name}-proxy-${var.private_region}"
  ip_cidr_range = var.cidr_proxy_prv
  region        = var.private_region
  network       = google_compute_network.vpc.id
  purpose       = "GLOBAL_MANAGED_PROXY"
  role          = "ACTIVE"
}