#############################################################
# ECS Task Execution Role
#############################################################

resource "aws_iam_role" "ecs_execution_role" {

  name = "${var.project_name}-ecs-execution-role"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]

  })

  tags = {
    Name = "${var.project_name}-ecs-execution-role"
  }

}

#############################################################
# Attach AWS Managed ECS Execution Policy
#############################################################

resource "aws_iam_role_policy_attachment" "ecs_execution_policy" {

  role = aws_iam_role.ecs_execution_role.name

  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"

}

#############################################################
# ECS Task Role
#############################################################

resource "aws_iam_role" "ecs_task_role" {

  name = "${var.project_name}-ecs-task-role"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [
      {

        Effect = "Allow"

        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }

        Action = "sts:AssumeRole"

      }
    ]

  })

  tags = {
    Name = "${var.project_name}-ecs-task-role"
  }

}

#############################################################
# Custom Policy
#############################################################

resource "aws_iam_policy" "ecs_custom_policy" {

  name = "${var.project_name}-ecs-custom-policy"

  description = "Policy for Birthday App ECS Tasks"

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      ###################################################
      # CloudWatch Logs
      ###################################################

      {

        Effect = "Allow"

        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:CreateLogGroup"
        ]

        Resource = "*"

      },

      ###################################################
      # Secrets Manager
      ###################################################

      {

        Effect = "Allow"

        Action = [
          "secretsmanager:GetSecretValue"
        ]

        Resource = "*"

      },

      ###################################################
      # ECR Read Access
      ###################################################

      {

        Effect = "Allow"

        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchCheckLayerAvailability"
        ]

        Resource = "*"

      }

    ]

  })

}

#############################################################
# Attach Custom Policy
#############################################################

resource "aws_iam_role_policy_attachment" "ecs_task_custom_policy" {

  role = aws_iam_role.ecs_task_role.name

  policy_arn = aws_iam_policy.ecs_custom_policy.arn

}