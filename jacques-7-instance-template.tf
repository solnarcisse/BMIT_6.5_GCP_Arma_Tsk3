# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance_template

resource "google_compute_instance_template" "region_b" {
  name         = "${var.app_name}-${var.region_b}-template"
  description  = "Brazil Instance Template"
  region       = var.region_b
  machine_type = "e2-medium"

  #Create a new disk from an image and set as boot disk
  disk {
    source_image = var.instance_image
    boot         = true
  }

  # Network Configurations 
  network_interface {
    subnetwork = google_compute_subnetwork.app-private.id
    access_config {}
  }
  #tags for internal firewall rule
  tags = ["app-internal"]

  # Install Webserver using file() function
  metadata_startup_script = file(".scripts/jacques.sh")
}

