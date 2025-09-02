resource "google_compute_network" "tko_arma_network" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
  routing_mode            = "GLOBAL"
}

# resource "google_compute_network" "vpc" {
#   name                    = var.vpc_name
#   auto_create_subnetworks = false
#   routing_mode            = "GLOBAL"
# }