resource "scaleway_ip" "node_ip" {
  count = "${var.nodes}"
}

data "scaleway_image" "ubuntu" {
  architecture = "${var.arch}"
  name         = "${var.ubuntu_version}"
}

resource "scaleway_server" "node" {
  count          = "${var.nodes}"
  name           = "${format("%s%01d", "${var.hostname}", count.index)}"
  image          = "${data.scaleway_image.ubuntu.id}"
  type           = "${var.server_type_node}"
  public_ip      = "${element(scaleway_ip.node_ip.*.ip, count.index)}"
  security_group = "${scaleway_security_group.node_security_group.id}"

  connection {
    type        = "ssh"
    user        = "root"
    private_key = "${file(var.private_key)}"
    timeout  = "2m"
  }
}
