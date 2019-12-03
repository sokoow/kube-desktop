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
        "chmod +x /tmp/bootstrap.sh",
        "sudo /tmp/bootstrap.sh"
      ]
    }

    provisioner "local-exec" {
      command = "../bin/deploy_kube.sh"
      on_failure = "fail"
    }

    provisioner "remote-exec" {
      inline = [
        "chmod +x /tmp/kube-provisioner.sh",
        "sudo /tmp/kube-provisioner.sh"
      ]
    }
}
