output "nodes" {
  value = ["${digitalocean_droplet.node.*.ipv4_address}"]
}
