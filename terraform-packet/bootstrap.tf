resource "null_resource" "kube-bootstrap" {

    depends_on = ["packet_device.node"]

    count = "${var.node_count}"

    connection {
        type = "ssh"
        host = "${element(packet_device.node.*.access_public_ipv4,count.index)}"
        private_key = "${file("${var.private_key_filename}")}"
        agent = false
    }
}
