resource "null_resource" "ansible_bootstrap" {

    depends_on = ["null_resource.bootstrap_wait",]
    count = 1

    connection {
        type = "ssh"
        user = "ubuntu"
        host = "${element(google_compute_instance.kube_node.*.network_interface.0.access_config.0.nat_ip,count.index)}"
        private_key = "${file("${var.private_key}")}"
        agent = false
    }

    provisioner "local-exec" {
      command = "sleep 5; ../bin/deploy_kube.sh"
      on_failure = "fail"
    }

}

resource "null_resource" "bootstrap_wait" {

    depends_on = ["google_compute_instance.kube_node",]
    count = 1

    connection {
        type = "ssh"
        user = "ubuntu"
        host = "${element(google_compute_instance.kube_node.*.network_interface.0.access_config.0.nat_ip,count.index)}"
        private_key = "${file("${var.private_key}")}"
        agent = false
    }

    provisioner "remote-exec" {
      inline = [
      "while [ ! -f /tmp/bootstrap_done ]; do sleep 2; done",
      ]
    }

}

resource "null_resource" "kube-bootstrap" {

    depends_on = ["google_compute_instance.kube_node",]

    count = "${var.instance_count}"

    connection {
        type = "ssh"
        user = "ubuntu"
        host = "${element(google_compute_instance.kube_node.*.network_interface.0.access_config.0.nat_ip,count.index)}"
        private_key = "${file("${var.private_key}")}"
        agent = false
    }

    provisioner "file" {
      source = "../scripts/"
      destination = "/tmp"
    }

    provisioner "remote-exec" {
      inline = [
        "chmod +x /tmp/bootstrap.sh",
        "sudo /tmp/bootstrap.sh",
        "sudo cp /home/ubuntu/.ssh/authorized_keys /root/.ssh/authorized_keys",
      ]
    }

    provisioner "remote-exec" {
      inline = [
        "while [ ! -f /tmp/bootstrap_done ]; do sleep 2; done",
        "while [ ! -f /tmp/ansible_done ]; do sleep 2; done",
        "chmod +x /tmp/kube-provisioner.sh",
        "sudo /tmp/kube-provisioner.sh"
      ]
    }
}
