############################################
# VPC
############################################

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

############################################
# Public Subnets
############################################

output "public_subnet_1" {
  description = "Public Subnet 1"
  value       = aws_subnet.public1.id
}

output "public_subnet_2" {
  description = "Public Subnet 2"
  value       = aws_subnet.public2.id
}

############################################
# Private Subnets
############################################

output "private_subnet_1" {
  description = "Private Subnet 1"
  value       = aws_subnet.private1.id
}

output "private_subnet_2" {
  description = "Private Subnet 2"
  value       = aws_subnet.private2.id
}

############################################
# Internet Gateway
############################################

output "internet_gateway_id" {
  description = "Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

############################################
# NAT Gateway
############################################

output "nat_gateway_id" {
  description = "NAT Gateway"
  value       = aws_nat_gateway.nat.id
}

############################################
# Application Load Balancer
############################################

output "alb_arn" {
  description = "ALB ARN"
  value       = aws_lb.birthday.arn
}

output "alb_dns_name" {
  description = "ALB DNS Name"
  value       = aws_lb.birthday.dns_name
}

output "alb_zone_id" {
  description = "ALB Hosted Zone ID"
  value       = aws_lb.birthday.zone_id
}

############################################
# Target Groups
############################################

output "frontend_target_group_arn" {
  description = "Frontend Target Group ARN"
  value       = aws_lb_target_group.frontend.arn
}

output "backend_target_group_arn" {
  description = "Backend Target Group ARN"
  value       = aws_lb_target_group.backend.arn
}

############################################
# ECS
############################################

output "ecs_cluster_name" {
  description = "ECS Cluster Name"
  value       = aws_ecs_cluster.birthday.name
}

output "ecs_cluster_arn" {
  description = "ECS Cluster ARN"
  value       = aws_ecs_cluster.birthday.arn
}

output "frontend_service_name" {
  description = "Frontend ECS Service"
  value       = aws_ecs_service.frontend.name
}

output "backend_service_name" {
  description = "Backend ECS Service"
  value       = aws_ecs_service.backend.name
}

############################################
# ECR
############################################

output "frontend_ecr_repository_url" {
  description = "Frontend ECR Repository URL"
  value       = aws_ecr_repository.frontend.repository_url
}

output "backend_ecr_repository_url" {
  description = "Backend ECR Repository URL"
  value       = aws_ecr_repository.backend.repository_url
}

############################################
# RDS
############################################

output "rds_endpoint" {
  description = "RDS Endpoint"
  value       = aws_db_instance.birthday_db.address
}

output "rds_port" {
  description = "RDS Port"
  value       = aws_db_instance.birthday_db.port
}

output "database_name" {
  description = "Database Name"
  value       = aws_db_instance.birthday_db.db_name
}

############################################
# CloudWatch
############################################

output "frontend_log_group" {
  description = "Frontend CloudWatch Log Group"
  value       = aws_cloudwatch_log_group.frontend.name
}

output "backend_log_group" {
  description = "Backend CloudWatch Log Group"
  value       = aws_cloudwatch_log_group.backend.name
}

############################################
# IAM
############################################

output "ecs_execution_role_arn" {
  description = "ECS Execution Role ARN"
  value       = aws_iam_role.ecs_execution_role.arn
}

output "ecs_task_role_arn" {
  description = "ECS Task Role ARN"
  value       = aws_iam_role.ecs_task_role.arn
}