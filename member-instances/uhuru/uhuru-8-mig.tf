
# Regional MIG in the member's region (size = 1)
resource "google_compute_region_instance_group_manager" "uhuru_mig" {
  name               = "${var.app_name}-uhuru-mig"
  region             = local.m.region
  base_instance_name = "${var.app_name}-uhuru"
  version {
    instance_template = google_compute_instance_template.uhuru_tmpl.self_link
  }
  target_size = 1

  named_port {
    name = "http"
    port = 80
  }
}

# Add this MIG as a backend to the global ILB
resource "google_compute_backend_service" "attach_dummy" {
  # Not used. We attach backends using 'google_compute_backend_service' above.
  # Avoid creating a second backend service; we just add backends to the global one:
  # Workaround: use a null_resource + google-beta not needed since google provider supports adding in-line backends:
}

# (Better): use a dedicated 'backend' block inside the global backend service using 'for_each'.
# Since google_compute_backend_service.ilb_backend is already created, we add a separate backend resource via 'google_compute_backend_service' cannot be updated here.
# So instead, do this: define one 'google_compute_backend_service' and add backends via separate resource 'google_compute_backend_service' is not splittable.
# Practical approach: re-declare all backends via a single place. We'll use a data to collect group links:

# Export the instance group's self_link to a module-level output so ilb.tf can stitch all members together.
output "uhuru_group_link" {
  value = google_compute_region_instance_group_manager.uhuru_mig.instance_group
}

# Firewall: allow ILB proxies (proxy-only subnets) + Windows tag to reach this member
resource "google_compute_firewall" "allow_member_http" {
  name    = "${var.app_name}-allow-uhuru-http"
  network = google_compute_network.vpc.name

  direction   = "INGRESS"
  target_tags = ["uhuru"]

  allows {
    protocol = "tcp"
    ports    = ["80","22"]
  }

  # ILB proxies + Windows subnet CIDRs as sources
  source_ranges = [
    var.cidr_proxy_pub,
    var.cidr_proxy_prv,
    var.cidr_public,   # Windows lives here (egress rule also limits who can reach)
  ]

  description = "Allow ILB proxies and Windows subnet to reach uhuru's VM"
}