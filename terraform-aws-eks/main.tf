terraform {
  required_version = ">= 0.12.2"
}

provider "aws" {
  version = ">= 2.28.1"
  region  = var.region
}

provider "random" {
  version = "~> 2.1"
}

provider "local" {
  version = "~> 1.2"
}

provider "null" {
  version = "~> 2.1"
}

provider "template" {
  version = "~> 2.1"
}

variable "filter_vpc_tags" {
  description = "VPC tags to find id using data"
  type        = map(string)
  default     = {"env" = "default"}
}

variable "filter_vpc_subnet_tags" {
  description = "VPC Subnet tags to find it using data"
  type        = map(string)
  default     = {"env" = "default"}
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

data "aws_vpc" "this" {
  tags = var.filter_vpc_tags
}

data "aws_subnet_ids" "this" {
  vpc_id = data.aws_vpc.this.id
  tags   = var.filter_vpc_subnet_tags
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
  version                = "~> 1.10"
}

data "aws_availability_zones" "available" {
}

locals {
  cluster_name = "test-eks-spot-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

module "eks" {
  source       = "./terraform-aws-eks"
  cluster_name = local.cluster_name
  subnets      = data.aws_subnet_ids.this.ids
  vpc_id       = data.aws_vpc.this.id

  worker_groups_launch_template = [
    {
      name                    = "spot-1"
      override_instance_types = ["m5a.xlarge"]
      spot_instance_pools     = 4
      asg_max_size            = 5
      asg_desired_capacity    = 1
      kubelet_extra_args      = "--node-labels=kubernetes.io/lifecycle=spot"
      spot_max_price          = "0.09"
      public_ip               = true
    },
  ]
}

resource "aws_lb_target_group" "this" {
  name     = "test-eks-spot-${random_string.suffix.result}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.this.id
  health_check {
     enabled = true
     interval = 30
     path = "/"
     port = "traffic-port"
     matcher = "200,404"
  }
}

resource "aws_security_group" "alb_sg" {
  name_prefix = "test-eks-spot-${random_string.suffix.result}"
  description = "Security group for all nodes in the cluster."
  vpc_id      = data.aws_vpc.this.id
}

resource "aws_security_group_rule" "alb_egress_internet" {
  description       = "Allow egress to the internet"
  protocol          = "-1"
  security_group_id = aws_security_group.alb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "alb_ingress_cluster_http" {
  description              = "Port 80 open to the world."
  protocol                 = "tcp"
  security_group_id        = aws_security_group.alb_sg.id
  from_port                = 80
  to_port                  = 80
  cidr_blocks              = ["0.0.0.0/0"]
  type                     = "ingress"
}

resource "aws_security_group_rule" "alb_ingress_cluster_https" {
  description              = "Port 443 open to the world"
  protocol                 = "tcp"
  security_group_id        = aws_security_group.alb_sg.id
  from_port                = 443
  to_port                  = 443
  cidr_blocks              = ["0.0.0.0/0"]
  type                     = "ingress"
}

resource "aws_lb" "this" {
  name               = "test-eks-spot-${random_string.suffix.result}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [ aws_security_group.alb_sg.id ]
  subnets            = data.aws_subnet_ids.this.ids

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

resource "aws_autoscaling_attachment" "this" {
  autoscaling_group_name = module.eks.workers_asg_names[0]
  alb_target_group_arn   = aws_lb_target_group.this.arn
}
