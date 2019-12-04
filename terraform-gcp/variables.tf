variable "cluster_name" {
  type        = "string"
  description = "Unique cluster name (prepended to dns_zone)"
  default     = "kube"
}

# Google Cloud

variable "region" {
  type        = "string"
  description = "Google Cloud Region (e.g. us-central1, see `gcloud compute regions list`)"
  default     = "europe-west4"
}

variable "gcp_account_name" {
  default = "ubuntu"
}

variable "instance_count" {
  description = "Number of instances"
  default     = 1
}

variable "instance_type" {
  type        = "string"
  description = "Machine type for controllers (see `gcloud compute machine-types list`)"
  default     = "n1-standard-2"
}

variable "os_image" {
  type        = "string"
  description = "Container Linux image for compute instances (e.g. coreos-stable)"
  default     = "ubuntu-1804-bionic"
}

variable "disk_size" {
  description = "Size of the disk in GB"
  default     = 50
}

# configuration

variable "public_key" {
  type        = "string"
  default     = "~/.ssh/id_rsa.pub"
  description = "The path to your public key"
}

variable "private_key" {
  type        = "string"
  default     = "~/.ssh/id_rsa"
  description = "The path to your private key"
}
