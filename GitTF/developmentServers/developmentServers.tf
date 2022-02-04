resource "aws_instance" "dev_server" {
  ami           = var.machine_image
  instance_type = var.machine_type
  key_name      = var.machine_key
}