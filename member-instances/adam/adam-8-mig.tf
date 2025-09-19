# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_instance_group_manager

# South Africa MIG
resource "google_compute_region_instance_group_manager" "app-mig01" {
  name               = var.app-mig01
  region             = var.vpcregion
  base_instance_name = "southafrica"
  target_size        = 2

  version {
    instance_template = google_compute_instance_template.temp01.self_link
  }

  distribution_policy_zones = [
    "africa-south1-a",
    "africa-south1-b",
    ]

  named_port {
    name = "http"
    port = 80
  }

  auto_healing_policies {
  health_check      = google_compute_health_check.apps-tsa-hc.id
  initial_delay_sec = 180
  }
}
