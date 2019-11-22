variable "hostname" {
  default = "kube"
}

resource "packet_device" "node" {

  #depends_on       = ["packet_ssh_key.host_key"]

  project_id       = "${var.packet_project_id}"
  facilities       = "${var.facilities}"
  plan             = "${var.node_type}"
  operating_system = "${var.operating_system}"
  hostname         = "${format("%s%01d", "${var.hostname}", count.index)}"

  count            = "${var.node_count}"

  billing_cycle    = "hourly"
  tags             = ["${var.build}","kube"]

  connection {
    user        = "root"
    private_key = "${file("${var.private_key_filename}")}"
  }
}
