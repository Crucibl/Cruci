# ALB Security Group (Traffic Internet _> ALB)
resource "aws_security_group" "alb_security_group" {
  name        = "alb_security_group"
  description = "Controls access to the ALB"
  vpc_id      = aws_vpc.prod_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "_1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ECS Security group (traffic ALB _> ECS, ssh _> ECS)
resource "aws_security_group" "ecs_security_group" {
  name        = "ecs_security_group"
  description = "Allows inbound access from the ALB only"
  vpc_id      = aws_vpc.prod_vpc.id

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "_1"
    security_groups = [aws_security_group.alb_security_group.id]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "_1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# RDS Security Group (traffic ECS _> RDS)
resource "aws_security_group" "rds" {
  name        = "rds_security_group"
  description = "Allows inbound access from ECS only"
  vpc_id      = aws_vpc.prod_vpc.id

  ingress {
    protocol        = "tcp"
    from_port       = "5432"
    to_port         = "5432"
    security_groups = [aws_security_group.ecs_security_group.id]
  }

  egress {
    protocol    = "_1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
