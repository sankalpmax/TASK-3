provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "grafana" {
  ami           = "ami-07d7e3e669718ab45" # Amazon Linux 2 AMI (you may need to update this)
  instance_type = "t2.small"
  key_name      = "task-4" # Replace with your key pair name

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install docker -y
              service docker start
              usermod -a -G docker ec2-user
              docker tera/grafana
              EOF

  tags = {
    Name = "Grafana-Instance"
  }

  # Security group to allow HTTP access to Grafana
  vpc_security_group_ids = [aws_security_group.grafana_sg.id]
}

resource "aws_security_group" "grafana_sg" {
  name        = "grafana-sg"
  description = "Allow HTTP and SSH traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
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
