
resource "aws_ecs_cluster" "main" {
  name = "ecs-cluster"
}

resource "aws_ecs_task_definition" "my_task" {
  family                   = "my-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.task_execution_role_arn
  task_role_arn            = var.task_execution_role_arn
   
  runtime_platform {
    operating_system_family = "LINUX"    # Set the OS family to Linux
    cpu_architecture        = "ARM64"    # Set the architecture to ARM64
  } 
  
  container_definitions = jsonencode([{
    name      = "my-container"
    image     = var.ecs_image
    essential = true
    portMappings = [{
      containerPort = 5000
      hostPort      = 5000
    }]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = "/ecs/my-task"
        awslogs-region        = "us-east-1"
        awslogs-stream-prefix = "ecs"
      }
    }
  }])
}

resource "aws_ecs_service" "my_service" {
  name            = "my-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.my_task.arn
  desired_count   = var.desired_task_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnet_ids
    assign_public_ip = false
    security_groups  = [var.alb_sg_id]
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "my-container"
    container_port   = 5000
  }
}

