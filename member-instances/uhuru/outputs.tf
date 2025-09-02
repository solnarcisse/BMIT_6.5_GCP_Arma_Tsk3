# This is the critical export: the Backend Service needs the instance group URL
output "instance_group_link" {
  value = google_compute_region_instance_group_manager.mig.instance_group
}

# (Optional) export the member tag so the root can create per-member firewall rules if desired
output "member_tag" {
  value = var.name
}
