locals {
  create_vpc     = "${var.vpc_override == "" ? true : false}"
  create_subnets = "${length(var.subnets_override) == 0 ? true : false}"
}

resource "random_id" "project_id" {
  byte_length  = 8
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = "${module.vpc.vpc_id}"
}

module "vpc" {
  source = "aws/vpc"

  name = "kubedesktop-${random_id.project_id.hex}"

  cidr = "172.16.0.0/16"

  azs             = "${local.azs}"
  private_subnets = ["172.16.1.0/24", "172.16.2.0/24", "172.16.3.0/24"]
  public_subnets  = ["172.16.101.0/24", "172.16.102.0/24", "172.16.103.0/24"]

  assign_generated_ipv6_cidr_block = false

  enable_nat_gateway = false
  single_nat_gateway = true

  public_subnet_tags = {
    Name = "kubedesktop-${random_id.project_id.hex}-public"
    Tier = "public"
  }

  private_subnet_tags = {
    Name = "kubedesktop-${random_id.project_id.hex}-public"
    Tier = "private"
  }

  tags = {
    Owner       = "kube-desktop"
    Environment = "kubedesktop"
  }

  vpc_tags = {
    Name = "kubedesktop-${random_id.project_id.hex}"
  }

}

module "aws_security_group" {
  source = "aws/sg"

  name   = "kubedesktop-${random_id.project_id.hex}"
  vpc_id = "${local.create_vpc ? module.vpc.vpc_id : var.vpc_override}"

  ingress_with_cidr_blocks = [
    {
      "from_port"   = "443"
      "to_port"     = "443"
      "protocol"    = "tcp"
      "cidr_blocks" = "0.0.0.0/0"
    },
    {
      "from_port"   = "80"
      "to_port"     = "80"
      "protocol"    = "tcp"
      "cidr_blocks" = "0.0.0.0/0"
    },
    {
      "from_port"   = "22"
      "to_port"     = "22"
      "protocol"    = "tcp"
      "cidr_blocks" = "0.0.0.0/0"
    },
  ]

  egress_with_cidr_blocks = [
    {
      "from_port"   = "0"
      "to_port"     = "65535"
      "protocol"    = "all"
      "cidr_blocks" = "0.0.0.0/0"
    },
  ]

  ingress_with_self = [{
    "from_port" = "0"
    "to_port"   = "65535"
    "protocol"  = "all"
  }]

}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["679593333241"] # Canonical
}

data "aws_subnet_ids" "all" {
  vpc_id = "${local.create_vpc ? module.vpc.vpc_id : var.vpc_override}"

  tags = {
  Tier = "public"
  }
  depends_on = ["module.vpc",]
}

module "ec2" {
  source = "aws/ec2"

  instance_count = "${var.instance_count}"

  name                        = "kube"
  ami                         = "${data.aws_ami.ubuntu.id}"
  instance_type               = "m4.large"
  subnet_id                   = "${element(data.aws_subnet_ids.all.ids, 0)}"
  vpc_security_group_ids      = ["${module.aws_security_group.this_security_group_id}"]
  associate_public_ip_address = true
  key_name = "myx230"
  user_data = "${file("scripts/userdata.sh")}"

  root_block_device = [{
    volume_type = "gp2"
    volume_size = 50
  }]
}
