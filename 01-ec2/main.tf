resource "aws_instance" "ec2" {
  ami                    = "ami-0220d79f3f480ecf5"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]

  tags = {
    Name        = "ec2-demo"
    Project     = "Roboshop"
    Environment = "Dev"
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "terraform-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"

  tags = {
    Name = "terraform-sg"
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}