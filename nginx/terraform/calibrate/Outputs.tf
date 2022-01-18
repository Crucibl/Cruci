output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}

output "calibrate_ecr_repository" {
  value = aws_ecr_repository.calibrate.repository_url
}

output "nginx_ecr_repository" {
  value = aws_ecr_repository.nginx.repository_url
}

output "rds_endpoint" {
  value = aws_db_instance.calibrate.endpoint
}

output "rds_username" {
  value = aws_db_instance.calibrate.username
}

output "rds_password" {
  value = aws_db_instance.calibrate.password
}

output "alb_hostname" {
  value = aws_lb.calibrate.dns_name
}
