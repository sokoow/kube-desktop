provider "scaleway" {
  region  = "${var.region}"
  version = "1.8.0"
}

provider "external" {
  version = "1.0.0"
}
