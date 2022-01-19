resource "aws_network_interface" "multi-ip" {
  subnet_id   = aws_subnet.public_access_1 
  private_ips = ["10.0.0.5", "10.0.0.11"]
}

resource "aws_eip" "one" {
  vpc                       = true
  network_interface         = aws_network_interface.multi-ip.id
  associate_with_private_ip = "10.0.0.5"
}

resource "aws_eip" "two" {
  vpc                       = true
  network_interface         = aws_network_interface.multi-ip.id
  associate_with_private_ip = "10.0.0.11"
}