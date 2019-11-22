output "nodes" {
  value = ["${packet_device.node.*.access_public_ipv4}"]
}
