variable "project_id" {
  default = "heroic-passkey-151820"
}

variable "gcp_zone" {
  default = "europe-west4-b"
}

provider "google" {
  credentials = "${file("~/.ssh/google.json")}"
  project     = "${var.project_id}"
  region      = "${var.region}"
  zone        = "${var.gcp_zone}"
  version     = "~> 2.5"
}
