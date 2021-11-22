data "terraform_remote_state" "local" {
  backend = "local"

  config = {
    path = "${path.module}/.terraform/terraform.tfstate"
  }
}

data "aws_caller_identity" "current" {}
