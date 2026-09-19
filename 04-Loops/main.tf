resource "aws_instance" "ec2" {
  count                  = 5
  ami                    = var.ami_id
  instance_type          = var.environment == "dev" ? "t3.micro" : "t3.small"
  vpc_security_group_ids = [aws_security_group.allow_tls[count.index].id]

  tags = {
    Name = "${var.project}-${var.environment}-${var.instance_names[count.index]}"
  }
}
resource "aws_security_group" "allow_tls" {
  count = 5
  name        = "${var.project}-${var.environment}-sg-${var.instance_names[count.index]}"
  description = "Allow TLS inbound traffic and all outbound traffic"

  tags = var.sg_tags

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

resource "aws_security_group" "common" {
  name        = "${var.project}-${var.environment}-common-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"

  tags = var.sg_tags

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}