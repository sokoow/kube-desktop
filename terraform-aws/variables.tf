variable "private_key" {
  type        = "string"
  default     = "~/.ssh/id_rsa"
  description = "The path to your private key"
}

variable "public_key" {
  type        = "string"
  default     = "~/.ssh/id_rsa.pub"
  description = "The path to your public key"
}

variable "instance_count" {
  description = "Count of instances"
  default     = 3
}

variable "vpc_override" {
  description = "Skip VPC creation and provide this id as the output instead"
  default     = ""
}

variable "azs_override" {
  description = "Explicitly set to a list of AZs"
  type        = "list"
  default     = []
}

variable "subnets_override" {
  description = "Skip subnet creation"
  type        = "list"
  default     = []
}
