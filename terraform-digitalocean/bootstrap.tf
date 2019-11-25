resource "null_resource" "kube-bootstrap" {

    depends_on = ["digitalocean_droplet.node"]

    count = "${var.node_number}"

    connection {
        type = "ssh"
        host = "${element(digitalocean_droplet.node.*.ipv4_address,count.index)}"
        private_key = "${file(var.private_key)}"
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
