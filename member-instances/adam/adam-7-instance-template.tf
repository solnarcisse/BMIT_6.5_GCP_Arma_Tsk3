# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance_template

# South Africa Instance Template
resource "google_compute_instance_template" "temp01" {
  name         = var.temp01
  description  = "South Africa Instance Template"
  machine_type = var.vm_machine_type
  region       = var.vpcregion

  disk {
    source_image = "debian-cloud/debian-12"
    boot         = true
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet02.id
    access_config {}
  }

  tags = ["southafrica", "adam"]

  metadata_startup_script = file("./adam.sh")
}

