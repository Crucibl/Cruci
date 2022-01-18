resource "aws_ecr_repository" "calibrate" {
  name                 = "calibrate-app"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "nginx" {
  name                 = "nginx"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "null_resource" "update_docker_calibrate" {
  provisioner "local-exec" {
    working_dir = "../../calibrate_app"
    command     = "./update-ecr.py --registry ${aws_ecr_repository.calibrate.repository_url}"
  }

  depends_on = [aws_ecr_repository.calibrate, aws_db_instance.calibrate, null_resource.rds_endpoint]
}

resource "null_resource" "update_docker_nginx" {
  provisioner "local-exec" {
    working_dir = "../../nginx"
    command     = "./update-ecr.py --registry ${aws_ecr_repository.nginx.repository_url}"
  }

  depends_on = [aws_ecr_repository.nginx]
}

resource "aws_key_pair" "ecs_key_pair" {
  key_name   = "${var.ecs_cluster_name}_key_pair"
  public_key = file(var.public_ssh_keyfile)
}

resource "aws_ecs_cluster" "calibrate" {
  name = "${var.ecs_cluster_name}_cluster"
}

resource "aws_launch_configuration" "ecs" {
  name                        = "${var.ecs_cluster_name}_cluster"
  image_id                    = lookup(var.ami_image, var.region)
  instance_type               = var.instance_type
  security_groups             = [aws_security_group.ecs_security_group.id]
  iam_instance_profile        = aws_iam_instance_profile.ecs.name
  key_name                    = aws_key_pair.ecs_key_pair.key_name
  associate_public_ip_address = true
  user_data                   = "#!/bin/bash\necho ECS_CLUSTER='${var.ecs_cluster_name}_cluster' > /etc/ecs/ecs.config"
}

data "template_file" "calibrate_app" {
  template = file("../templates/calibrate_app.json.tpl")

  vars = {
    calibrate_docker_url = aws_ecr_repository.calibrate.repository_url
    nginx_docker_url     = aws_ecr_repository.nginx.repository_url
    region               = var.region
    rds_db_name          = var.rds_db_name
    rds_username         = var.rds_username
    rds_password         = var.rds_password
    rds_hostname         = aws_db_instance.calibrate.address
    allowed_hosts        = var.allowed_hosts
  }
  depends_on = [aws_db_instance.calibrate, aws_ecr_repository.calibrate, aws_ecr_repository.nginx]
}

resource "aws_ecs_task_definition" "calibrate_app" {
  family                = "django_app"
  container_definitions = data.template_file.calibrate_app.rendered
  depends_on            = [aws_db_instance.calibrate]

  volume {
    name      = "static_volume"
    host_path = "/usr/src/app/staticfiles/"
  }
}

resource "aws_ecs_service" "calibrate" {
  name            = "${var.ecs_cluster_name}_service"
  cluster         = aws_ecs_cluster.calibrate.id
  task_definition = aws_ecs_task_definition.calibrate_app.arn
  iam_role        = aws_iam_role.ecs_service_role.arn
  desired_count   = var.app_count
  depends_on      = [aws_alb_listener.ecs_alb_http_listener, aws_iam_role_policy.ecs_service_role_policy]

  load_balancer {
    target_group_arn = aws_alb_target_group.default_target_group.arn
    container_name   = "nginx"
    container_port   = 80
  }
}
