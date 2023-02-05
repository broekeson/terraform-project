#Provider
provider "aws" {
  region = var.region
}

#Create EC2 Security Group
resource "aws_security_group" "ec2_sg" {
  name   = var.sg_name
  vpc_id = var.sg_vpc_id

  dynamic "ingress" {
    for_each = var.ec2_ingress
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = var.ec2_protocol
      cidr_blocks = var.ec2_cidr_blocks
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = var.ec2_tags
  }

}

#Create Load Balance Security Group
resource "aws_security_group" "load_sg" {
  name        = var.lb_sg_name
  description = var.lb_sg_description
  vpc_id      = var.lb_sg_vpc_id

  dynamic "ingress" {
    for_each = var.lb_sg_ingress
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = var.lb_protocol
      cidr_blocks = var.lb_sg_cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.lb_tags
  }
}

#Load Balancer access to EC2
resource "aws_security_group_rule" "allow_lb" {
  type                     = "ingress"
  from_port                = var.allow_lb_port
  to_port                  = var.allow_lb_port
  protocol                 = var.allow_lb_protocol
  security_group_id        = aws_security_group.ec2_sg.id
  source_security_group_id = aws_security_group.load_sg.id
}
