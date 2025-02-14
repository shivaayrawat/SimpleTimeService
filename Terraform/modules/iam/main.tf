

# IAM Role for ECS Task Execution (with ECR permissions)
resource "aws_iam_role" "task_execution" {
  name = "ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

# Attach AmazonECSTaskExecutionRolePolicy to the ECS task execution role

resource "aws_iam_role_policy_attachment" "task_execution_policy" {
  role       = aws_iam_role.task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Security Group for Load Balancer
resource "aws_security_group" "lb_sg" {
  name        = "lb_sg"
  description = "Security group for Load Balancer"
  vpc_id      = var.vpc_id
}
