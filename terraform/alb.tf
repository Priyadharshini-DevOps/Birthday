resource "aws_lb" "birthday" {

  name               = "birthday-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    aws_security_group.alb.id
  ]

  subnets = [
    aws_subnet.public1.id,
    aws_subnet.public2.id
  ]
}

###########################
# Frontend Target Group
###########################

resource "aws_lb_target_group" "frontend" {

  name = "frontend-tg"

  port     = 80
  protocol = "HTTP"

  target_type = "ip"

  vpc_id = aws_vpc.main.id

  health_check {

    path = "/"

  }

}

###########################
# Listener
###########################

resource "aws_lb_listener" "http" {

  load_balancer_arn = aws_lb.birthday.arn

  port = 80

  protocol = "HTTP"

  default_action {

    type = "forward"

    target_group_arn = aws_lb_target_group.frontend.arn

  }

}

#########################################
# Backend Target Group
#########################################

resource "aws_lb_target_group" "backend" {

  name = "backend-tg"

  port     = 3000
  protocol = "HTTP"

  target_type = "ip"

  vpc_id = aws_vpc.main.id

  health_check {

    path                = "/health"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2

  }

}

#########################################
# API Listener Rule
#########################################

resource "aws_lb_listener_rule" "backend" {

  listener_arn = aws_lb_listener.http.arn

  priority = 10

  action {

    type = "forward"

    target_group_arn = aws_lb_target_group.backend.arn

  }

  condition {

    path_pattern {

      values = ["/api/*"]

    }

  }

}