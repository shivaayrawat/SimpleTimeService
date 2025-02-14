resource "aws_ecr_repository" "my_repository" {
  name = var.ecr_repository_name

  tags = {
    Name        = var.ecr_repository_name
    Environment = "production"
  }
}

resource "null_resource" "push_to_ecr" {
  depends_on = [aws_ecr_repository.my_repository]

  provisioner "local-exec" {
    command = <<EOT
      # Log in to ECR using AWS CLI
      aws ecr get-login-password --region ${var.region} | docker login --username AWS --password-stdin ${aws_ecr_repository.my_repository.repository_url}

      # Tag the local Docker image with the ECR URI
      docker tag ${var.docker_image_name} ${aws_ecr_repository.my_repository.repository_url}:latest

      # Push the Docker image to ECR
      docker push ${aws_ecr_repository.my_repository.repository_url}:latest
    EOT
  }
}


