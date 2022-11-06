# Security group for AWS ELB
resource "aws_security_group" "demo-elb-sg" {
  vpc_id      = aws_vpc.demo-vpc.id
  name        = "demo-elb-sg"
  description = "security group for ELB"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "demo-elb-sg"
  }
}

# Security group for instances
resource "aws_security_group" "demo-instance-sg" {
  vpc_id      = aws_vpc.demo-vpc.id
  name        = "demo-instance-sg"
  description = "security group for instances"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 22
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.demo-elb-sg.id]
  }

  tags = {
    "Name" = "demo-instance-sg"
  }
}