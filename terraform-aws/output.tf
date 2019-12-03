output "vpc_availability_zones" {
  description = "Availability zones in use in the selected VPC"
  value       = ["${local.azs}"]
}

# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = "${module.vpc.vpc_id}"
}

# CIDR blocks
output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = ["${module.vpc.vpc_cidr_block}"]
}

//output "vpc_ipv6_cidr_block" {
//  description = "The IPv6 CIDR block"
//  value       = ["${module.vpc.vpc_ipv6_cidr_block}"]
//}

# Subnets
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = ["${module.vpc.private_subnets}"]
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = ["${module.vpc.public_subnets}"]
}

# NAT gateways
output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = ["${module.vpc.nat_public_ips}"]
}

# AZs
output "azs" {
  description = "A list of availability zones spefified as argument to this module"
  value       = ["${module.vpc.azs}"]
}

output "ids" {
  description = "List of IDs of instances"
  value       = "${module.ec2.id}"
}

output "public_dns" {
  description = "List of public DNS names assigned to the instances"
  value       = "${module.ec2.public_dns}"
}

output "public_ip" {
  description = "The ID of the VPC"
  value       = "${module.ec2.public_ip}"
}

output "private_ip" {
  description = "The ID of the VPC"
  value       = "${module.ec2.private_ip}"
}
