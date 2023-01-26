resource "aws_lb" "wp_alb" {
  name               = "wp-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public_subnet_a.id, aws_subnet.public_subnet_b.id]

  tags = merge(
    var.common_tags,
    {
      Name = "wp-alb"
    }
  )
}

resource "aws_lb_target_group" "wp_alb_tg" {
  #   name     = "WP ALB Target Group"
  port     = "80"
  protocol = "HTTP"
  vpc_id   = aws_vpc.wordpress-workshop.id
}

resource "aws_lb_target_group_attachment" "wp_alb_tg_attachment" {
  target_group_arn = aws_lb_target_group.wp_alb_tg.arn
  target_id        = aws_instance.test_instance.id
  port             = 80
}

resource "aws_lb_listener" "wp_alb_listener" {
  load_balancer_arn = aws_lb.wp_alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.wp_alb_tg.id
    type             = "forward"
  }
}