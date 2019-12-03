resource "aws_key_pair" "kube-keypair" {
  # TODO figure out something better for customers
  key_name   = "kube-desktop-key"
  public_key = "${file(var.public_key)}"
}
