# APPLICATION LOAD BALANCER
# terraform create application load balancer

resource "aws_lb" "thelma-alb" {
  name               = "thelma-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.thelma-vpc-security-group.id]

  subnet_mapping {
    subnet_id = aws_subnet.thelma-PUB1-SUB1.id
  }

  subnet_mapping {
    subnet_id = aws_subnet.thelma-PUB2-SUB2.id
  }

  enable_deletion_protection = false

  tags = {
    name = "thelma1"
  }
}

# TARGET GROUP

resource "aws_alb_target_group" "thelma_alb_target_group" {
  name        = "thelma1-tg"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.thelma-VPC.id

  health_check {
    healthy_threshold   = 5
    interval            = 30
    matcher             = "200,300"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }
}

# LISTENER ON PORT 80 WITH REDIRECT APPLICATION

resource "aws_lb_listener" "thelma-alb-listener" {
  load_balancer_arn = aws_lb.thelma-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.thelma_alb_target_group.arn
  }
}