# ===========================================================
# Security Group for App Server
# ===========================================================
resource "aws_security_group" "app_sg" {
  name        = "app-server-sg"
  description = "Allow SSH and HTTP traffic"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "AppServerSG"
  }
}

# ===========================================================
# EC2 Instance for App Server (Amazon Linux 2023)
# ===========================================================
resource "aws_instance" "app_server" {
  ami                    = "ami-080c353f4798a202f" # Amazon Linux 2023 x86_64 UEFI
  instance_type          = "t2.micro"
  key_name               = "Security"
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.codedeploy_instance_profile.name

  tags = {
    Name        = "AppServer"
    Environment = "Development"
  }

  user_data = <<-EOF
              #!/bin/bash
              set -e

              # Update system
              sudo dnf update -y

              # Install basic dependencies
              sudo dnf install -y wget awscli

              # Install Ruby 3.2
              sudo dnf install -y ruby ruby-devel
              ruby -v

              # Install Docker
              sudo dnf install -y docker
              sudo systemctl start docker
              sudo systemctl enable docker
              sudo usermod -aG docker ec2-user

              # Configure AWS CLI region globally
              echo "export AWS_DEFAULT_REGION=us-east-1" >> /etc/profile
              export AWS_DEFAULT_REGION=us-east-1

              # Install CodeDeploy agent
              cd /home/ec2-user
              wget https://aws-codedeploy-us-east-1.s3.amazonaws.com/latest/install
              chmod +x ./install
              sudo ./install auto
              sudo systemctl enable codedeploy-agent
              sudo systemctl start codedeploy-agent

              echo "Setup complete: Ruby, Docker, and CodeDeploy agent installed successfully."
              EOF

  provisioner "local-exec" {
    command = "echo \"EC2 instance created and all required software installed successfully.\""
  }
}
