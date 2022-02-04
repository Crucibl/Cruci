variable "engineer_name" {
  type    = list(string)
  default = ["first.last"]
}

variable "git_repos" {
  type    = list(string)
  default = ["dragonrepo"]
}

variable "github_token" {
  type = string
}

variable "github_organization" {
  type = string
}