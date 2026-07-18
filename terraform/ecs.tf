############################################
# ECS Cluster
############################################

resource "aws_ecs_cluster" "birthday" {

  name = "${var.project_name}-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name        = "${var.project_name}-cluster"
    Environment = var.environment
  }
}

############################################
# Capacity Providers
############################################

resource "aws_ecs_cluster_capacity_providers" "birthday" {

  cluster_name = aws_ecs_cluster.birthday.name

  capacity_providers = [
    "FARGATE",
    "FARGATE_SPOT"
  ]

  default_capacity_provider_strategy {

    capacity_provider = "FARGATE"

    weight = 100

  }

}

############################################
# Frontend Task Definition
############################################

resource "aws_ecs_task_definition" "frontend" {

  family                   = "${var.project_name}-frontend"
  requires_compatibilities = ["FARGATE"]

  network_mode = "awsvpc"

  cpu    = "256"
  memory = "512"

  execution_role_arn = aws_iam_role.ecs_execution_role.arn
  task_role_arn      = aws_iam_role.ecs_task_role.arn

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions = jsonencode([

    {

      name = "frontend"

      image = "${aws_ecr_repository.frontend.repository_url}:latest"

      essential = true

      portMappings = [

        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }

      ]

      logConfiguration = {

        logDriver = "awslogs"

        options = {

          awslogs-group         = aws_cloudwatch_log_group.frontend.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"

        }

      }

      environment = [

        {
          name  = "API_URL"
          value = "http://localhost:3000"
        }

      ]

    }

  ])

  tags = {

    Name        = "${var.project_name}-frontend-task"
    Environment = var.environment

  }

}

############################################
# Backend Task Definition
############################################

resource "aws_ecs_task_definition" "backend" {

  family                   = "${var.project_name}-backend"
  requires_compatibilities = ["FARGATE"]

  network_mode = "awsvpc"

  cpu    = "512"
  memory = "1024"

  execution_role_arn = aws_iam_role.ecs_execution_role.arn
  task_role_arn      = aws_iam_role.ecs_task_role.arn

  runtime_platform {

    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"

  }

  container_definitions = jsonencode([

    {

      name = "backend"

      image = "${aws_ecr_repository.backend.repository_url}:latest"

      essential = true

      portMappings = [

        {

          containerPort = 3000
          hostPort      = 3000
          protocol      = "tcp"

        }

      ]

      environment = [

        {
          name  = "DB_HOST"
          value = aws_db_instance.birthday_db.address
        },

        {
          name  = "DB_PORT"
          value = "3306"
        },

        {
          name  = "DB_NAME"
          value = var.db_name
        },

        {
          name  = "DB_USER"
          value = var.db_username
        },

        {
          name  = "DB_PASSWORD"
          value = var.db_password
        },

        {
          name  = "NODE_ENV"
          value = "production"
        }

      ]

      logConfiguration = {

        logDriver = "awslogs"

        options = {

          awslogs-group         = aws_cloudwatch_log_group.backend.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"

        }

      }

    }

  ])

  tags = {

    Name        = "${var.project_name}-backend-task"
    Environment = var.environment

  }

}

############################################
# Frontend ECS Service
############################################

resource "aws_ecs_service" "frontend" {

  name = "frontend-service"

  cluster = aws_ecs_cluster.birthday.id

  task_definition = aws_ecs_task_definition.frontend.arn

  desired_count = 1

  launch_type = "FARGATE"

  network_configuration {

    assign_public_ip = false

    subnets = [

      aws_subnet.private1.id,
      aws_subnet.private2.id

    ]

    security_groups = [

      aws_security_group.ecs.id

    ]

  }

  load_balancer {

    target_group_arn = aws_lb_target_group.frontend.arn

    container_name = "frontend"

    container_port = 80

  }

  depends_on = [

    aws_lb_listener.http

  ]

}

############################################
# Backend ECS Service
############################################

resource "aws_ecs_service" "backend" {

  name            = "backend-service"
  cluster         = aws_ecs_cluster.birthday.id
  task_definition = aws_ecs_task_definition.backend.arn

  desired_count = 1

  launch_type = "FARGATE"

  platform_version = "LATEST"

  enable_execute_command = true

  network_configuration {

    assign_public_ip = false

    subnets = [
      aws_subnet.private1.id,
      aws_subnet.private2.id
    ]

    security_groups = [
      aws_security_group.ecs.id
    ]

  }

  load_balancer {

    target_group_arn = aws_lb_target_group.backend.arn

    container_name = "backend"

    container_port = 3000

  }

  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200

  health_check_grace_period_seconds = 60

  depends_on = [
    aws_lb_listener.http,
    aws_lb_listener_rule.backend
  ]

  tags = {
    Name        = "${var.project_name}-backend-service"
    Environment = var.environment
  }

}

