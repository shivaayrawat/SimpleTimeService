variable "subnets" {
  description = "The subnets to associate with the load balancer"
  type        = list(string)
}

variable "vpc_id" {
  description = "The VPC ID in which the load balancer will reside"
  type        = string
}

variable "name" {
  description = "The name of the load balancer"
  type        = string
}

variable "internal" {
  description = "Whether the load balancer is internal"
  type        = bool
  default     = false
}

variable "security_groups" {
  description = "The security groups associated with the load balancer"
  type        = list(string)
}

variable "load_balancer_type" {
  description = "The type of load balancer"
  type        = string
  default     = "application"
}

variable "enable_http2" {
  description = "Whether HTTP/2 is enabled"
  type        = bool
  default     = true
}

variable "enable_deletion_protection" {
  description = "Whether deletion protection is enabled"
  type        = bool
  default     = false
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}