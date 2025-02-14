




output "ecr_image_uri" {
  value = module.ecr.ecr_image_uri
}

output "load_balancer_dns" {
  value = module.load_balancer.dns_name  # Corrected to match output name from load_balancer module
}
