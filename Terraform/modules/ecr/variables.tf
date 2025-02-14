variable "ecr_repository_name" {
  description = "Name of the ECR repository"
  type        = string
  default     = "central-registry"
}

variable "docker_image_name" {
  description = "Name of the Docker image to be pushed"
  type        = string
  default     = "simple-time-service:latest"  # You can change this value as needed
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}