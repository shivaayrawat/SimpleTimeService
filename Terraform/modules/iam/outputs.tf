output "task_execution_role_arn" {
  value = aws_iam_role.task_execution.arn
}

output "lb_security_group" {
  value = aws_security_group.lb_sg.id
}