# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_autoscaler

# South Africa Autoscaler
resource "google_compute_region_autoscaler" "autoscale01" {
  name   = var.autoscale01
  region = var.vpcregion
  target = google_compute_region_instance_group_manager.app-mig01.id

  autoscaling_policy {
    max_replicas    = 3
    min_replicas    = 2
    cooldown_period = 60

    cpu_utilization {
      target = 0.25
    }
  }
}

