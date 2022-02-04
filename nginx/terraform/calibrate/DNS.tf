resource "aws_route53_resolver_endpoint" "DNS" {
  name      = "DNS"
  direction = "INBOUND"

  security_group_ids = [
    aws_security_group.ecs_security_group.id,
  ]

  ip_address {
    subnet_id = aws_subnet.public_subnet_1.id
    ip        = "10.0.1.0/24"
  }

  ip_address {
    subnet_id = aws_subnet.public_subnet_1.id
    ip        = "10.0.2.0/24"
  }

  tags = {
    Environment = "prod"
  }
}