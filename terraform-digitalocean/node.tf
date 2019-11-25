resource "digitalocean_droplet" "node" {

    image = "ubuntu-18-04-x64"
    name = "${format("%s%01d", "kube", count.index)}"
    count = "${var.node_number}"

    region = "${var.do_region}"
    private_networking = true
    size = "${var.node_size}"
    ssh_keys = ["${split(",", var.ssh_fingerprint)}"]

    tags             = ["kube"]

    connection {
        type = "ssh",
        private_key = "${file(var.private_key)}"
    }
}
