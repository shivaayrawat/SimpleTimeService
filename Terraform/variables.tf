variable "region" {
  description = "The AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_public_a_cidr" {
  description = "CIDR block for Public Subnet A"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnet_public_b_cidr" {
  description = "CIDR block for Public Subnet B"
  type        = string
  default     = "10.0.2.0/24"
}

variable "subnet_private_a_cidr" {
  description = "CIDR block for Private Subnet A"
  type        = string
  default     = "10.0.3.0/24"
}

variable "subnet_private_b_cidr" {
  description = "CIDR block for Private Subnet B"
  type        = string
  default     = "10.0.4.0/24"
}

variable "lb_name" {
  description = "The name of the Load Balancer"
  type        = string
  default     = "my-load-balancer"
}

variable "desired_task_count" {
  description = "Desired number of ECS tasks"
  type        = number
  default     = 1
}


# root variables.tf




variable "task_execution_role_arn" {
  description = "ARN of the ECS task execution role"
  type        = string
  default     = "arn:aws:iam::123456789012:role/ecs-task-execution-role"
}


variable "ecr_repository_name" {
  description = "Name of the ECR repository"
  type        = string
  default     = "central-registry"
}

variable "docker_image_name" {
  description = "Docker image name including the tag"
  type        = string
  default     = "simple-time-service:latest"
}
