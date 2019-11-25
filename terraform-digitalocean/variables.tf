variable "do_token" {}

variable "do_region" {
    default = "fra1"
}

variable "private_key" {
    default = "~/.ssh/id_rsa"
}

variable "node_number" {
	default = "1"
}

variable "node_size" {
    default = "4gb"
}
