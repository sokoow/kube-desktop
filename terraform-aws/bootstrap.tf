resource "null_resource" "ansible-bootstrap" {

    depends_on = ["module.ec2",]
    count = 1

    connection {
        type = "ssh"
        user = "ubuntu"
        host = "${element(module.ec2.public_ip,count.index)}"
        private_key = "${file("${var.private_key}")}"
        agent = false
    }

    provisioner "remote-exec" {
      inline = [
      "while [ ! -f /tmp/userdata_done ]; do sleep 2; done",
      "while [ ! -f /tmp/bootstrap_done ]; do sleep 2; done",
      ]
    }

    provisioner "local-exec" {
      command = "sleep 5; ../bin/deploy_kube.sh; touch /tmp/ansible_done"
      on_failure = "fail"
    }
}

resource "null_resource" "kube-bootstrap" {

    depends_on = ["module.ec2",]

    count = "${var.instance_count}"

    connection {
        type = "ssh"
        user = "ubuntu"
        host = "${element(module.ec2.public_ip,count.index)}"
        private_key = "${file("${var.private_key}")}"
        agent = false
    }

    provisioner "file" {
      source = "../scripts/"
      destination = "/tmp"
    }

    provisioner "remote-exec" {
      inline = [
        "sleep 10",
        "while [ ! -f /tmp/userdata_done ]; do sleep 2; done",
        "chmod +x /tmp/bootstrap.sh",
        "sudo /tmp/bootstrap.sh"
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
