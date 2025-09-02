# Single Windows VM in the public (North America) region
resource "google_compute_instance" "win" {
  name         = "${var.app_name}-win"
  machine_type = var.win_machine_type
  zone         = "${var.public_region}-b"

  tags = ["windows", "rdp-public"]

  boot_disk {
    initialize_params {
      image = "windows-cloud/windows-server-2022-dc-v20240813" # update as needed
      size  = 50
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.public.id
    access_config {} # ephemeral public IP to allow RDP (or use IAP if preferred)
  }

  metadata = {
    windows-startup-script-ps1 = <<-EOPS
      # optional: install Chrome/Edge or OpenSSH client if desired
    EOPS
  }
}
