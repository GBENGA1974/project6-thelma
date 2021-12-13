# SECURITY GROUP FOR VPC
# terraform aws create security GROUP

resource "aws_security_group" "thelma-vpc-security-group" {
  name        = "thelma-vpc-security-group"
  description = "Allow SSH/HTTP access or port 22/80"
  vpc_id      = aws_vpc.thelma-VPC.id

  ingress {
    description = "SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP Access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "thelma-vpc-security-group"
  }
}