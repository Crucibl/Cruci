resource "aws_cloudwatch_log_group" "django_log_group" {
  name              = "/ecs/calibrate-app"
  retention_in_days = var.log_retention_policy
}

resource "aws_cloudwatch_log_stream" "django_log_stream" {
  name           = "calibrate-app-log-stream"
  log_group_name = aws_cloudwatch_log_group.django_log_group.name
}

resource "aws_cloudwatch_log_group" "nginx_log_group" {
  name              = "/ecs/nginx"
  retention_in_days = var.log_retention_policy
}

resource "aws_cloudwatch_log_stream" "nginx_log_stream" {
  name           = "nginx-log-stream"
  log_group_name = aws_cloudwatch_log_group.nginx_log_group.name
}
