resource "aws_instance" "service" {
  ami           = "ami-05b10e08d247fb927"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.service.id
  vpc_security_group_ids = [aws_security_group.service.id]
  associate_public_ip_address = true  # Ensures the instance gets a public IP
  key_name = "openvpn"
  
  tags = {
    Name = "service"
  }
}