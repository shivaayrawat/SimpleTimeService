
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "subnet_public_a_cidr" {
  description = "The CIDR block for the public subnet in availability zone A"
  type        = string
}

variable "subnet_public_b_cidr" {
  description = "The CIDR block for the public subnet in availability zone B"
  type        = string
}

variable "subnet_private_a_cidr" {
  description = "The CIDR block for the private subnet in availability zone A"
  type        = string
}

variable "subnet_private_b_cidr" {
  description = "The CIDR block for the private subnet in availability zone B"
  type        = string
}
