provider "google" {
  credentials = file("/Users/Cos-Ibe/sandbox-project-362420-a4dde5787a0c.json")
  project     = "sandbox-project-362420"
  region      = "europe-west1"
}

resource "google_compute_instance" "ubuntu_instance" {
  name         = "ansible-ubuntu-instance"
  machine_type = "e2-medium"
  zone         = "europe-west1-b"
  tags         = ["ansible-vm"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  metadata = {
  ssh-keys = "ansible:${file("~/.ssh/ansbile.pub")}"
}


  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP
    }
  }
}
