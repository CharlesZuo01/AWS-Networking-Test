
resource "aws_security_group" "instance" {
  name        = "openvpn-default"
  description = "OpenVPN security group"
  vpc_id   = aws_vpc.vpn-vpc.id

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"] 
  }
}

resource "aws_security_group" "service" {
  name        = "service"
  description = "service security group"
  vpc_id   = aws_vpc.vpn-vpc.id


  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}