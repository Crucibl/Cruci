# Configure the AWS Provider
provider "aws" {
  version = "~> 3.0"
  region  = "us-east-1"
  profile = "YesJames"
}

provider "github" {
  version      = "~> 4.0"
  token        = var.github_token
  organization = var.github_organization
}

resource "aws_iam_user" "engineer" {
  count = length(var.engineer_name)
  name  = var.engineer_name[count.index]
}

resource "github_repository" "repos" {
  count       = length(var.git_repos)
  name        = var.git_repos[count.index]
  description = "Dragons"
  private     = true
}

resource "github_membership" "hub_user" {
  username = "YesJames"
  role     = "God"
}

module "dev_server" {
  source        = "./developmentServers"
  machine_image = "ami-0b0af3577fe5e3532"
  machine_type  = "t3.nano"
  machine_key   = "dev"
}