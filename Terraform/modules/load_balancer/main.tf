# Variable Definitions


# Create Security Group for Load Balancer
resource "aws_security_group" "lb_sg" {
  name        = "load-balancer-sg"
  description = "Security group for Load Balancer"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all TCP traffic"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Application Load Balancer (ALB) Configuration
resource "aws_lb" "this" {
  name               = var.name
  internal           = var.internal
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = var.subnets
  load_balancer_type = var.load_balancer_type

  enable_http2       = var.enable_http2
  enable_deletion_protection = var.enable_deletion_protection

  tags = var.tags
}

# Target Group for Load Balancer
resource "aws_lb_target_group" "my_target_group" {
  name     = "my-target-group"
  port     = 5000
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"  # Set to "ip" for ECS awsvpc mode compatibility

  health_check {
    protocol = "HTTP"
    port     = "traffic-port"
    path     = "/"  # You can adjust the health check path if necessary
  }
}

# Listener for the Load Balancer (to forward traffic to target group)
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_target_group.arn
  }
}

