# Provider block for AWS
provider "aws" {
  region = var.region
}

# VPC Module
module "vpc" {
  source                = "./modules/vpc"
  vpc_cidr_block        = var.vpc_cidr_block
  subnet_public_a_cidr  = var.subnet_public_a_cidr
  subnet_public_b_cidr  = var.subnet_public_b_cidr
  subnet_private_a_cidr = var.subnet_private_a_cidr
  subnet_private_b_cidr = var.subnet_private_b_cidr
}

# IAM Module
module "iam" {
  source = "./modules/iam"
  vpc_id = module.vpc.vpc_id  # Pass the VPC ID from the vpc module
}

# ECR Module
module "ecr" {
  source = "./modules/ecr"
  # ECR module now handles the creation and output of the repository URI
}

# Load Balancer Module
module "load_balancer" {
  source          = "./modules/load_balancer"
  name            = var.lb_name
  subnets         = module.vpc.public_subnets              # Use public subnets from VPC
  security_groups = [module.iam.lb_security_group]         # Use IAM module security group
  vpc_id          = module.vpc.vpc_id                     # Pass VPC ID
}

# ECS Module
module "ecs" {
  source                  = "./modules/ecs"
  subnet_ids              = module.vpc.private_subnets       # Use private subnets from VPC
  ecs_image               = module.ecr.ecr_image_uri        # Use the ECR image URI dynamically from ECR module
  desired_task_count      = var.desired_task_count
  task_execution_role_arn = module.iam.task_execution_role_arn  # Use IAM output for task execution role ARN
  alb_sg_id               = tolist(module.load_balancer.security_groups)[0]  # Use Load Balancer security group dynamically
  target_group_arn        = module.load_balancer.target_group_arn  # Pass target group ARN
}
