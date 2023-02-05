resource "aws_lb" "lb" {
  name               = var.lb_name
  internal           = var.lb_internal
  load_balancer_type = var.lb_load_balancer_type
  security_groups    = var.lb_security_groups
  subnets            = var.lb_subnets

  enable_deletion_protection = var.lb_enable_deletion_protection

  tags = var.lb_tags
}

#Load Balancer Listener
resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = var.lb_listener_port
  protocol          = var.lb_listener_protocol

  default_action {
    target_group_arn = aws_lb_target_group.lb_target_group.arn
    type             = "forward"
  }
}

#Load Balancer Target Group
resource "aws_lb_target_group" "lb_target_group" {
  name     = var.lb_target_group_name
  port     = var.lb_target_group_port
  protocol = var.lb_target_group_protocol
  vpc_id   = var.vpc_id

  health_check {
    healthy_threshold   = var.check_healthy_threshold
    unhealthy_threshold = var.check_unhealthy_threshold
    timeout             = var.check_timeout
    interval            = var.check_interval
    path                = "/"
  }
}

#Load Balancer Target Group Attachment
resource "aws_lb_target_group_attachment" "lb_target_group_attachment" {
  count = length(var.lb_target_group_attachment_target_id)
  target_group_arn = aws_lb_target_group.lb_target_group.arn
  target_id        = var.lb_target_group_attachment_target_id[count.index]
  port             = var.lb_target_group_attachment_port
}