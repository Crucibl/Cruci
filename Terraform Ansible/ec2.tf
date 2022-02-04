provider "aws" {
    profile = "new"
    region = var.region
}


resource "aws_instance" "ansible-control-server" {
  ami = var.James_ami
  instance_type = var.James_instance
  tags = {
    "Name" = "Ansible-control"
  }
  key_name = var.key_name
}

resource "aws_instance" "ansible-web-servers" {
  count = length(var.web_servers)
  ami = var.James_ami
  instance_type = var.James_instance
  tags = {
    "Name" = element(var.web_servers, count.index)
  }
  key_name = var.key_name
}