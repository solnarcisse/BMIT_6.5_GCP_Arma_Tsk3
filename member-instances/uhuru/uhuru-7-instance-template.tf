# Pick the key from var.members
locals {
  m = var.members["uhuru"]
}

# Member-specific instance template (tags include the member's short name)
resource "google_compute_instance_template" "uhuru_tmpl" {
  name_prefix  = "${var.app_name}-uhuru-"
  machine_type = local.m.machine_type

  tags = [ "web", "uhuru" ]   # <-- firewall tag named after member

  disk {
    auto_delete  = true
    boot         = true
    source_image = "debian-cloud/debian-12"
  }

  network_interface {
    subnetwork = local.m.region == var.private_region
    access_config {}
    #    google_compute_subnetwork.private.id
    #    google_compute_subnetwork.public.id
    # No external IP — stays private behind ILB
  }

  metadata = {
    full_name       = local.m.full_name
    annual_amount   = local.m.annual_amount
    thanks_person   = local.m.thanks_person
    peaceful_bg_url = local.m.peaceful_bg_url
    promo_img_url   = local.m.promo_img_url
    startup-script  = templatefile("${path.module}/../templates/linux_startup.sh", {})
  }

  metadata_startup_script = templatefile("${path.module}/../templates/linux_startup.sh", {})
}

