resource "google_compute_instance" "vm_instance" {
  name         = var.instance_name
  machine_type = var.machine_type # 1 vCPU and 1 GB memory
  zone         = var.region_vm

  boot_disk {
    initialize_params {
      image  = "debian-cloud/debian-11"
      size   = 10  # 10 GB boot disk size
      type   = "pd-balanced"  # Balanced persistent disk type (SSD equivalent)
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }
}

output "external_ip" {
  value = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
}
