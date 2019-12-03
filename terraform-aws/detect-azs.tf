data "aws_availability_zones" "available" {

}

locals {
  all_available_azs = ["${data.aws_availability_zones.available.names}"]
  sorted_azs        = ["${distinct(sort(local.all_available_azs))}"]

  default_azs = [
    "${element(local.sorted_azs, 0)}",
    "${element(local.sorted_azs, 1)}",
    "${element(local.sorted_azs, 2)}",
  ]

  default_scalar_azs = "${join(":", local.default_azs)}"
  var_scalar_azs     = "${join(":", var.azs_override)}"
  scalar_azs         = "${length(var.azs_override) > 0 ? local.var_scalar_azs : local.default_scalar_azs}"
  azs                = ["${split(":", local.scalar_azs)}"]
}
