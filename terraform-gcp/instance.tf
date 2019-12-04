resource "google_compute_instance_group" "kube_group" {
  name      = "staging-instance-group"
  zone      = "${var.gcp_zone}"
  instances = ["${google_compute_instance.kube_node.self_link}"]
  named_port {
    name = "http"
    port = "80"
  }

  named_port {
    name = "https"
    port = "443"
  }

  named_port {
    name = "kubeapi"
    port = "6443"
  }

  lifecycle {
    create_before_destroy = true
  }
}

data "google_compute_image" "ubuntu_image" {
  family  = "ubuntu-1804-lts"
  project = "ubuntu-os-cloud"
}

resource "google_compute_instance" "kube_node" {
  name         = "kube"
  count        = "${var.instance_count}"

  machine_type = "${var.instance_type}"
  zone         = "${var.gcp_zone}"
  boot_disk {
    initialize_params {
      image = "${data.google_compute_image.ubuntu_image.self_link}"
      size  = "${var.disk_size}"
    }
  }

  metadata {
    "block-project-ssh-keys" = "true"
    "sshKeys"                = "${var.gcp_account_name}:${file("~/.ssh/id_rsa.pub")} \nroot:${file("~/.ssh/id_rsa.pub")}"
  }

  network_interface {
    network = "default"

    access_config {
    // Include this section to give the VM an external ip address
    }

  }
}

resource "google_compute_backend_service" "staging_service" {
  name      = "staging-service"
  port_name = "https"
  protocol  = "HTTPS"

  backend {
    group = "${google_compute_instance_group.kube_group.self_link}"
  }

  health_checks = [
    "${google_compute_https_health_check.staging_health.self_link}",
  ]
}

resource "google_compute_https_health_check" "staging_health" {
  name         = "staging-health"
  request_path = "/health_check"
}
