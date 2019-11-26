resource "null_resource" "kube-bootstrap" {

    depends_on = ["packet_device.node"]

    count = "${var.node_count}"

    connection {
        type = "ssh"
        host = "${element(packet_device.node.*.access_public_ipv4,count.index)}"
        private_key = "${file("${var.private_key_filename}")}"
        agent = false
    }

    provisioner "file" {
      source = "../scripts/"
      destination = "/tmp"
    }

    provisioner "remote-exec" {
      inline = [
        "chmod +x /tmp/bootstrap.sh",
        "/tmp/bootstrap.sh"
      ]
    }

    provisioner "local-exec" {
      command = "../bin/deploy_kube.sh"
      on_failure = "continue"
    }

    provisioner "remote-exec" {
      inline = [
        "chmod +x /tmp/kube-provisioner.sh",
        "/tmp/kube-provisioner.sh"
      ]
    }
}
