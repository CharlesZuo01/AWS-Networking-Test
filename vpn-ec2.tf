resource "aws_instance" "openvpn" {
  ami                    = "ami-037ff6453f0855c46"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]
  subnet_id              = aws_subnet.vpn.id
  associate_public_ip_address = true  # Ensures the instance gets a public IP
  key_name        = aws_key_pair.openvpn.openvpn
  
  tags = {
    Name = "openvpn"
  }
}

