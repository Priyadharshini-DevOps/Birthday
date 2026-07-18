#############################################################
# CloudWatch Log Group - Frontend
#############################################################

resource "aws_cloudwatch_log_group" "frontend" {

  name              = "/ecs/${var.project_name}/frontend"
  retention_in_days = 30

  tags = {
    Name        = "${var.project_name}-frontend-logs"
    Environment = "Dev"
  }
}

#############################################################
# CloudWatch Log Group - Backend
#############################################################

resource "aws_cloudwatch_log_group" "backend" {

  name              = "/ecs/${var.project_name}/backend"
  retention_in_days = 30

  tags = {
    Name        = "${var.project_name}-backend-logs"
    Environment = "Dev"
  }
}