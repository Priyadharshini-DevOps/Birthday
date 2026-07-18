#############################
# ALB Security Group
#############################

resource "aws_security_group" "alb" {

  name   = "birthday-alb-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

#############################
# ECS Security Group
#############################

resource "aws_security_group" "ecs" {

  name   = "birthday-ecs-sg"
  vpc_id = aws_vpc.main.id

  ingress {

    from_port       = 80
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]

  }

  egress {

    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

}

#############################
# RDS Security Group
#############################

resource "aws_security_group" "rds" {

  name   = "birthday-rds-sg"
  vpc_id = aws_vpc.main.id

  ingress {

    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs.id]

  }

}