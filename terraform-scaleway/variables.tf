variable "ubuntu_version" {
  default = "Ubuntu Bionic"
  description = <<EOT

For arm, choose from:
  - Ubuntu Xenial

For x86_64, choose from:
  - Ubuntu Xenial
  - Ubuntu Bionic

EOT
}

variable "hostname" {
  default = "kube"
}

variable "arch" {
  default     = "x86_64"
  description = "Values: arm arm64 x86_64"
}

variable "region" {
  default     = "par1"
  description = "Values: par1 ams1"
}

variable "server_type" {
  default     = "DEV1-M"
  description = "Use C1 for arm, ARM64-2GB for arm64 and C2S for x86_64"
}

variable "server_type_node" {
  default     = "DEV1-M"
  description = "Use C1 for arm, ARM64-2GB for arm64 and C2S for x86_64"
}

variable "nodes" {
  default = 1
}

variable "ip_admin" {
  type        = "list"
  default     = ["0.0.0.0/0"]
  description = "IP access to services"
}

variable "private_key" {
  type        = "string"
  default     = "~/.ssh/id_rsa"
  description = "The path to your private key"
}

variable "ssh_fingerprint" {
  default = ""
}

variable "ssh_public_key" {
  description = "SSH public key to be copied on machines"
  default = "~/.ssh/id_rsa.pub"
}

variable "ssh_private_key" {
  description = "SSH private key to be used to log into machines"
  default = "~/.ssh/id_rsa"
}
