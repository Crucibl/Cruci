variable "region" {
  default = "us-west-1"
}

variable "key_name" {
  default = "cloud"
}

variable "James_ami" {
  default = 
}


variable "James_instance" {
  default = t3.nano
}

variable "web_servers" {
  type = list(string)
  default = [
      ansible-web-1
      ansible-web-2
      ansible-web-3
      ansible-web-4
      ansible-web-5
  ]
}