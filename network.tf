data "http" "myip" {
  url = "https://ifconfig.me"
}

data "aws_subnets" "target_vpc_subnets" {
  filter {
    name   = "vpc-id"
    values = [var.target_vpc]
  }
}

resource "aws_security_group" "CloudGaming" {
  name        = "CloudGaming"
  description = "Allow rdp, ssh, moonlight, NiceDCV"
  vpc_id      = var.target_vpc
  ingress {
    description = "Window remote desktop"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["${data.http.myip.body}/32"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${data.http.myip.body}/32"]
  }
  ingress {
    description = "Virtual Desktop VR"
    from_port   = 38810
    to_port     = 38840
    protocol    = "tcp"
    cidr_blocks = ["${data.http.myip.body}/32"]
  }
  ingress {
    description = "Virtual Desktop VR"
    from_port   = 38810
    to_port     = 38840
    protocol    = "udp"
    cidr_blocks = ["${data.http.myip.body}/32"]
  }
  ingress {
    description = "NiceDCV QUIC"
    from_port   = 8443
    to_port     = 8443
    protocol    = "tcp"
    cidr_blocks = ["${data.http.myip.body}/32"]
  }
  ingress {
    description = "NiceDCV QUIC"
    from_port   = 8443
    to_port     = 8443
    protocol    = "udp"
    cidr_blocks = ["${data.http.myip.body}/32"]
  }
  ingress {
    description = "moonlight"
    from_port   = 47984
    to_port     = 47984
    protocol    = "tcp"
    cidr_blocks = ["${data.http.myip.body}/32"]
  }
  ingress {
    description = "moonlight"
    from_port   = 47984
    to_port     = 47984
    protocol    = "tcp"
    cidr_blocks = ["${data.http.myip.body}/32"]
  }
  ingress {
    description = "moonlight"
    from_port   = 47984
    to_port     = 47984
    protocol    = "tcp"
    cidr_blocks = ["${data.http.myip.body}/32"]
  }
  ingress {
    description = "moonlight"
    from_port   = 47998
    to_port     = 48000
    protocol    = "udp"
    cidr_blocks = ["${data.http.myip.body}/32"]
  }
  ingress {
    description = "moonlight"
    from_port   = 48002
    to_port     = 48002
    protocol    = "udp"
    cidr_blocks = ["${data.http.myip.body}/32"]
  }
  ingress {
    description = "moonlight"
    from_port   = 48010
    to_port     = 48010
    protocol    = "udp"
    cidr_blocks = ["${data.http.myip.body}/32"]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Gaming & VR"
  }
}