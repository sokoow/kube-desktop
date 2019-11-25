resource "null_resource" "kube-bootstrap" {

    depends_on = ["scaleway_server.node"]

    count = "${var.nodes}"

    connection {
        type = "ssh"
        host = "${element(scaleway_ip.node_ip.*.ip,count.index)}"
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
