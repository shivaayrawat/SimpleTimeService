# Output DNS name of the Load Balancer
output "dns_name" {
  description = "DNS name of the Load Balancer"
  value       = aws_lb.this.dns_name
}

# Output Security Groups associated with Load Balancer
output "security_groups" {
  value = aws_lb.this.security_groups  # Expose security_groups for use in other modules
}
output "target_group_arn" {
  description = "The ARN of the target group"
  value       = aws_lb_target_group.my_target_group.arn
}