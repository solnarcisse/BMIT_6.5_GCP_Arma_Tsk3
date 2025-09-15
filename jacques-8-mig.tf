# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_zones

data "google_compute_zones" "brazil-available" {
  status = "UP"
  region = var.region_b
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_instance_group_manager
resource "google_compute_region_instance_group_manager" "brazil" {
  name               = "${var.app_name}-${var.region_b}-mig"
  region             = var.region_b
  base_instance_name = "brazil"
  target_size        = 3

  # Compute zones to be used for VM creation
  distribution_policy_zones = data.google_compute_zones.brazil-available.names


  #Instance Template
  version {
    instance_template = google_compute_instance_template.region_b.id
  }

  # Named Port
  named_port {
    name = var.backend_port_name
    port = 80
  }

  auto_healing_policies {
    health_check      = google_compute_health_check.health-hc.id
    initial_delay_sec = 60
  }
}
