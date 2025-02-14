variable "subnet_ids" {
  description = "List of subnet IDs for the ECS service"
  type        = list(string)
}

variable "ecs_image" {
  description = "Docker image URI for the ECS task"
  type        = string
}

variable "desired_task_count" {
  description = "Desired number of ECS tasks"
  type        = number
}

variable "task_execution_role_arn" {
  description = "The IAM role ARN for ECS task execution"
  type        = string
}

variable "alb_sg_id" {
  description = "The security group ID for the load balancer"
  type        = string
}

variable "target_group_arn" {
  description = "The ARN of the load balancer target group"
  type        = string
}
