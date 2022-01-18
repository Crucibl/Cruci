resource "aws_iam_role" "ecs_host_role" {
  name               = "ecs_host_role_prod"
  assume_role_policy = file("../policies/ecs_role.json")
}

resource "aws_iam_role_policy" "ecs_instance_role_policy" {
  name   = "ecs_instance_role_policy"
  policy = file("../policies/ecs_instance_role_policy.json")
  role   = aws_iam_role.ecs_host_role.id
}

resource "aws_iam_role" "ecs_service_role" {
  name               = "ecs_service_role_prod"
  assume_role_policy = file("../policies/ecs_role.json")
}

resource "aws_iam_role_policy" "ecs_service_role_policy" {
  name   = "ecs_service_role_policy"
  policy = file("../policies/ecs_service_role_policy.json")
  role   = aws_iam_role.ecs_service_role.id
}

resource "aws_iam_instance_profile" "ecs" {
  name = "ecs_instance_profile_prod"
  path = "/"
  role = aws_iam_role.ecs_host_role.name
}
